//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import Combine
import OSLog
import SnapCore

public class SettingsService {
	
	/// Creates a `SettingsService` with option to specify stores.
	/// - Parameters:
	///   - defaults: `UserDefaults` to use for `Scope.defaults`. If no value is provided, `UserDefaults.standard` is used.
	///   - ubiquitous: `NSUbiquitousKeyValueStore` to use for `Scope.ubiquitous`. If no value is provided, `NSUbiquitousKeyValueStore.default` is used.
	///   - storesForCustomScopes: `[Scope : SettingsStore]` to define `SettingsStore`s to use with `Scope.custom`.
	public init(defaults: UserDefaults? = .standard, ubiquitous: NSUbiquitousKeyValueStore? = .default, storesForCustomScopes: [Scope : SettingsStore] = [:]) {
		
		var storeForScope: [Scope: SettingsStore] = [:]
		storeForScope[.defaults] = defaults
		storeForScope[.ubiquitous] = ubiquitous
		storeForScope.merge(storesForCustomScopes, uniquingKeysWith: { $1 })
		self.storeForScope = storeForScope
		
		if ubiquitous != nil {		
			setupSettingsSync()
		}
	}
	
	
	// MARK: Stores

	private let storeForScope: [Scope : SettingsStore]
	
	private func store(for scope: Scope) -> SettingsStore? {
		storeForScope[scope]
	}
	
	
	// MARK: Get
	
	public func get<T>(_ setting: Setting<T>) -> T {
		let data: Data? = getData(setting.key)
		
		return SettingsService.createValue(with: data, for: setting)
	}
	
	private func getData(_ key: StorageKey) -> Data? {
		guard let store = store(for: key.scope) else {
			Logger.settings.warning("Could not GET setting for '\(key.name)'. No Store available for '\(key.scope.name)'.")
			return nil
		}
		
		return store.get(key)
	}
	
	private static func createValue<T>(with data: Data?, for setting: Setting<T>) -> T {
		if let data, let object: T = SettingsService.decodeObject(data, for: setting.key) {
			return object
		} else {
			return setting.defaultValue
		}
	}

	
	// MARK: Set
	
	public func set<T>(_ setting: Setting<T>, to value: T) {
		guard let store = store(for: setting.key.scope) else {
			Logger.settings.warning("Could not SET setting for '\(setting.key.name)'. No Store available for '\(setting.key.scope.name)'.")
			return
		}
		let data = SettingsService.encodeData(value, for: setting.key)
		
		store.set(setting.key, to: data)

		triggerPublisher(for: setting.key)
	}
	
	
	// MARK: Encoding
	
	private static func decodeObject<T: Decodable>(_ data: Data, for key: StorageKey) -> T? {
		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			Logger.settings.error("Failed to decode data for setting '\(key.name)': \(error.localizedDescription)")
			return nil
		}
	}

	private static func encodeData<T: Encodable>(_ value: T, for key: StorageKey) -> Data? {
		do {
			return try JSONEncoder().encode(value)
		} catch {
			Logger.settings.error("Failed to encode data for setting '\(key.name)': \(error.localizedDescription)")
			return nil
		}
	}
	
	
	// MARK: - Publisher

	private typealias DataPublisher = CurrentValueSubject<Data?, Never>
	
	
	// MARK: Storage
	
	private var publisherForKey: [StorageKey : WeakRef<DataPublisher>] = [:]
	
	private func publisher(for key: StorageKey) -> DataPublisher? {
		publisherForKey[key]?.value as? DataPublisher
	}
	
	private func cleanupPublishers() {
		for key in publisherForKey.keys {
			if let ref = publisherForKey[key], ref.isEmpty {
				publisherForKey.removeValue(forKey: key)
			}
		}
	}
	
	
	// MARK: Get
	
	private func publisherPing<T>(_ setting: Setting<T>) -> DataPublisher {
		if let publisher = publisher(for: setting.key) {
			return publisher
		} else {
			let data = getData(setting.key)
			let publisher = DataPublisher(data)
			publisherForKey[setting.key] = WeakRef<DataPublisher>(value: publisher)
			return publisher
		}
	}
	
	public func publisher<T>(_ setting: Setting<T>) -> AnyPublisher<T, Never> {
		publisherPing(setting)
			.map { data in
				SettingsService.createValue(with: data, for: setting)
			}
			.eraseToAnyPublisher()
	}
	
	
	// MARK: Trigger
	
	private func triggerPublishers(for scope: Scope) {
		cleanupPublishers()
		
		let keysToTrigger = publisherForKey.keys.filter { key in
			key.scope == scope
		}
		
		for key in keysToTrigger {
			triggerPublisher(for: key)
		}
		
	}
	
	private func triggerPublisher(for key: StorageKey) {
		if let publisher = publisher(for: key) {
			let data = getData(key)
			publisher.send(data)
		}
	}
	
	
	// MARK: - Remote Notification
	
	private var subscriptions: [AnyCancellable] = []
	private func setupSettingsSync() {
		NotificationCenter.default
			.publisher(for: NSUbiquitousKeyValueStore.didChangeExternallyNotification)
			.receive(on: DispatchQueue.main)
			.withWeak(self)
			.sink(receiveValue: { weakSelf, output in
				weakSelf.triggerPublishers(for: .ubiquitous)
				Logger.settings.info("NSUbiquitousKeyValueStore.didChangeExternallyNotification - Number of publisher triggered: \(weakSelf.publisherForKey.keys.count)")
			})
			.store(in: &subscriptions)
	}
	
}
