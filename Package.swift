// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Combinefall",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Combinefall",
            targets: ["Combinefall"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Combinefall",
            dependencies: []),
        .testTarget(
            name: "CombinefallTests",
            dependencies: ["Combinefall"])
    ]
)
