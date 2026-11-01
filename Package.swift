// swift-tools-version: 6.3

import PackageDescription

let package = Package(
	name: "snap-settings-service",
	platforms: [
		.iOS(.v18), .macOS(.v15),
	],
	products: [
		.library(
			name: "SnapSettingsService",
			targets: ["SnapSettingsService"],
		),
	],
	dependencies: [
		.package(url: "https://github.com/simonnickel/snap-core.git", branch: "main"),
	],
	targets: [
		.target(
			name: "SnapSettingsService",
			dependencies: [
				.product(name: "SnapCore", package: "snap-core"),
			],
		),
	],
)
