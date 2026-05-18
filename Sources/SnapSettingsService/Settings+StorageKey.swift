//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension SettingsService {
	
	/// Identifies a setting by its string name and the scope it is stored in.
	struct StorageKey: Hashable, Equatable, Sendable {
		
		public typealias NameType = String
	
		let name: NameType
		let scope: Scope
		
	}
	
}
