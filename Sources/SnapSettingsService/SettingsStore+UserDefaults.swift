//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
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
