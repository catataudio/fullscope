// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClipBrowser",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.9.1")
    ],
    targets: [
        .executableTarget(
            name: "ClipBrowser",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios")
            ],
            resources: [
                .process("GraphQL/schema.graphqls")
            ]
        ),
    ]
)
