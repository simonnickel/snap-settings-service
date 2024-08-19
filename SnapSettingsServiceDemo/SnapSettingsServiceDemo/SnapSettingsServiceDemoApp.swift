//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapSettingsService

@main
struct SnapSettingsServiceDemoApp: App {
	
	private let customStore: CustomStore
	private let settings: SettingsService
	
	init() {
		self.customStore = CustomStore()
		self.settings = SettingsService(storesForCustomScopes: [CustomStore.scope : customStore])
	}
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.serviceSettings, settings)
        }
    }
}
