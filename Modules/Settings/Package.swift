// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.1"))
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
                "SnapKit"
            ],
            resources: [
                .process("Resources/Assets.xcassets")
            ]
        ),
    ]
)
