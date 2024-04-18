//
//  SnapSettingsServiceDemoApp.swift
//  SnapSettingsServiceDemo
//
//  Created by Simon Nickel on 18.04.24.
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
