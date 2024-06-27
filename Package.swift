// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "snap-settings-service",
	platforms: [
		.iOS(.v18), .macOS(.v15)
	],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "SnapSettingsService",
			targets: ["SnapSettingsService"]
		),
	],
	dependencies: [
		// Dependencies declare other packages that this package depends on.
		.package(url: "https://github.com/simonnickel/snap-core.git", branch: "main-xc16"), // TODO: Switch back to main
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SnapSettingsService",
			dependencies: [
				.product(name: "SnapCore", package: "snap-core"),
			],
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			]
		),
        .testTarget(
            name: "SnapSettingsServiceTests",
            dependencies: ["SnapSettingsService"]
		),
    ]
	// TODO: swiftLanguageVersions: [.version("6")]
)
