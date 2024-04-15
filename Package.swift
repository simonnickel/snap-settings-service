// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "snap-settings-service",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SnapSettingsService",
            targets: ["SnapSettingsService"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SnapSettingsService"),
        .testTarget(
            name: "SnapSettingsServiceTests",
            dependencies: ["SnapSettingsService"]),
    ]
)
