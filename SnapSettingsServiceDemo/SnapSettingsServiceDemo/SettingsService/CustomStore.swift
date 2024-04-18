//
//  CustomStore.swift
//  SnapSettingsServiceDemo
//
//  Created by Simon Nickel on 06.10.23.
//

import Foundation
import SnapSettingsService

class CustomStore: SettingsStore {
	
	static let scope: SettingsService.Scope = .custom(id: "Custom")
	
	private var store: [SettingsService.StorageKey : Data] = [:]
	
	func get(_ key: SettingsService.StorageKey) -> Data? {
		store[key]
	}
	
	func set(_ key: SettingsService.StorageKey, to data: Data?) {
		store[key] = data
	}
	
}
