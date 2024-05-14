//
//  SettingsService+Environment.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 09.10.23.
//

import SwiftUI

private struct SettingsServiceKey: EnvironmentKey {
	
	static var defaultValue: SettingsService {
		SettingsService(defaults: nil, ubiquitous: nil)
	}
	
}

public extension EnvironmentValues {
	
	var serviceSettings: SettingsService {
		get { self[SettingsServiceKey.self] }
		set { self[SettingsServiceKey.self] = newValue }
	}
	
}
