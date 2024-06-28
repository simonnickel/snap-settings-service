//
//  Settings+Value.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 06.10.23.
//

import SwiftUI
import Observation
import Combine

public extension SettingsService {
	
	@MainActor
	func value<T: SettingsService.SettingDefinition.TypeRequirement>(_ setting: Setting<T>) -> Value<T> {
		Value(settings: self, setting: setting)
	}
	
	@MainActor
	@Observable class Value<T: SettingDefinition.TypeRequirement> {
		
		private let settings: SettingsService
		private let setting: SettingsService.Setting<T>
		
		private var publisher: AnyCancellable? = nil
		
		public init(settings: SettingsService, setting: SettingsService.Setting<T>) {
			self.settings = settings
			self.setting = setting
			
			value = settings.get(setting)
			publisher = settings.publisher(setting)
				.sink { [weak self] value in
					self?.value = value
				}
		}
		
		public private(set) var value: T
		
		public func set(_ value: T) {
			self.value = value
			self.settings.set(self.setting, to: value)
		}
		
		public var binding: Binding<T> {
			Binding<T> { @MainActor in
				self.value
			} set: { @MainActor value, transaction in
				self.set(value)
			}
		}
		
	}
	
}
