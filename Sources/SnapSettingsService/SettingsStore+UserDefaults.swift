//
//  SettingsStore+UserDefaults.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 04.10.23.
//

import Foundation

extension UserDefaults: SettingsStore {
	
	public func get(_ key: SettingsService.StorageKey) -> Data? {
		return data(forKey: key.name)
	}

	public func set(_ key: SettingsService.StorageKey, to data: Data?) {
		set(data, forKey: key.name)
	}
	
}
