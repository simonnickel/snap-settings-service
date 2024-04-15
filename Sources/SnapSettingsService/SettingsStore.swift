//
//  SettingsStore.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 04.10.23.
//

import Foundation

public protocol SettingsStore {
	
	func get(_ key: SettingsService.StorageKey) -> Data?
	func set(_ key: SettingsService.StorageKey, to data: Data?)
	
}
