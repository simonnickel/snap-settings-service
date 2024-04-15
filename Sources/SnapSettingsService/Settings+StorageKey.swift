//
//  Settings+Setting.swift
//  SnapSettingsService
//
//  Created by Simon Nickel on 04.10.23.
//

import Foundation

public extension SettingsService {
	
	struct StorageKey: Hashable, Equatable, Sendable {
		
		public typealias NameType = String
	
		let name: NameType
		let scope: Scope
		
	}
	
}
