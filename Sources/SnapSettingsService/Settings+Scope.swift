//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension SettingsService {
	
	enum Scope: Hashable, Equatable, Sendable {
		
		/// For local settings, stored in UserDefaults.
		case defaults
		
		/// For synced settings, stored in NSUbiquitousKeyValueStore.
		/// Make sure iCloud entitlement is configured.
		case ubiquitous
		
		/// A custom `Scope` to use with a provided `SettingsStore`.
		/// Don't forget to add the store in `SettingsService(storesForCustomScope:)`.
		case custom(id: String)
		
		public var name: String {
			switch self {
				case .defaults: "Scope.defaults"
				case .ubiquitous: "Scope.ubiquitous"
				case .custom(id: let id): "Scope.custom(\(id))"
			}
		}
		
	}
	
}
