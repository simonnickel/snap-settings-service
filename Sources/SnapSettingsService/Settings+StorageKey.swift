//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension SettingsService {
	
	struct StorageKey: Hashable, Equatable, Sendable {
		
		public typealias NameType = String
	
		let name: NameType
		let scope: Scope
		
	}
	
}
