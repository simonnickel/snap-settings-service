//
//  SettingsService+Environment.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 09.10.23.
//

import SwiftUI

private struct SettingsServiceKey: EnvironmentKey {
	
	static var defaultValue: SettingsService {
		// TODO concurrency: Instead of a `static let` this needs to be a computed property. Just applying @MainActor does not fullfill requirements for `EnvironmentKey` implementation.
		// Not sure if this might be something that is solved in a future version of Swift or SwiftUI.EnvironmentKey.
		// Static property 'defaultValue' is not concurrency-safe because it is not either conforming to 'Sendable' or isolated to a global actor; this is an error in Swift 6
		// Main actor-isolated static property 'defaultValue' cannot be used to satisfy nonisolated protocol requirement
		SettingsService(defaults: nil, ubiquitous: nil)
	}
	
}

public extension EnvironmentValues {
	
	var serviceSettings: SettingsService {
		get { self[SettingsServiceKey.self] }
		set { self[SettingsServiceKey.self] = newValue }
	}
	
}
