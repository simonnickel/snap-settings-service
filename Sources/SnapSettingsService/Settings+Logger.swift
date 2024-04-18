//
//  Settings+Logger.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 05.10.23.
//

import Foundation
import OSLog
import SnapCore

internal extension Logger {
	
	static let settings = Logger(category: "SettingsService")
	
}

// TODO concurrency: Remove once @preconcurrency works as expected.
// This fixes the warning on Logger.settings not being concurrency safe. Should apply @preconcurrency import OSLog instead.
// https://forums.swift.org/t/preconcurrency-doesnt-suppress-static-property-concurrency-warnings/70469/2
extension Logger: @unchecked Sendable {}
