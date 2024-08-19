//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation
import SnapSettingsService

extension SettingsService.SettingDefinition {
	
	static let settingsLocal = SettingsService.Setting<Bool>("settingsLocal", in: .defaults, default: false)
	static let settingsSynced = SettingsService.Setting<Bool>("settingsSynced", in: .ubiquitous, default: false)
	static let settingsCustom = SettingsService.Setting<Bool>("settingsCustom", in: CustomStore.scope, default: false)
	
	static let settingsStoreNotAvailable = SettingsService.Setting<Bool>("settingsStoreNotAvailable", in: .custom(id: "None"), default: false)
	
}
