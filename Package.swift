// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokedexCLI",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "PokedexCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
    ]
)
