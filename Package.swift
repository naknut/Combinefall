// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Combinefall",
    platforms: [.iOS(.v15), .watchOS(.v8), .macOS(.v12)],
    products: [.library(name: "Combinefall", targets: ["Combinefall"])],
    targets: [
        .target(name: "Combinefall"),
        .testTarget(name: "CombinefallTests",
                    dependencies: ["Combinefall"],
                    resources: [.process("TestData")])
    ]
)
