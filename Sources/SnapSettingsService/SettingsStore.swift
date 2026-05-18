//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

/// A key-value store abstraction used by ``SettingsService`` to persist setting data.
public protocol SettingsStore {
	
	func get(_ key: SettingsService.StorageKey) -> Data?
	func set(_ key: SettingsService.StorageKey, to data: Data?)
	
}
