// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Combinefall",
    platforms: [
        .macOS(.v11), .iOS(.v14), .watchOS(.v7)
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
