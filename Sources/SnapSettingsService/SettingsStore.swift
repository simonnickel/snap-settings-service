//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public protocol SettingsStore {
	
	func get(_ key: SettingsService.StorageKey) -> Data?
	func set(_ key: SettingsService.StorageKey, to data: Data?)
	
}
