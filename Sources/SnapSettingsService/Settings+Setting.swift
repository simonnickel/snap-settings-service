//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension SettingsService {
	
	class SettingDefinition {
		public typealias TypeRequirement = Codable & Sendable
	}
	
	/// A `SettingDefinition` with a specific type defined as generic. Consists of a key the setting is stored for and a default value in case no setting is defined yet.
	///
	/// Has to be @unchecked because: `'Sendable' class 'Setting' cannot inherit from another class other than 'NSObject'`. Needs to inherit from `SettingDefinition` to add static settings in an extension, which is not allowed on generic types. They have to be available on `Setting` though to be able to access them in short form: `settings.value(.mySetting)`.
	final class Setting<T: SettingDefinition.TypeRequirement>: SettingDefinition, @unchecked Sendable {
	
		public let key: StorageKey
		public let defaultValue: T
		
		public init(_ name: StorageKey.NameType, in scope: Scope, default defaultValue: T) {
			self.key = StorageKey(name: name, scope: scope)
			self.defaultValue = defaultValue
		}
		
	}
	
}
