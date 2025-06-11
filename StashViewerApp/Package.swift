// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "StashViewerApp",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "StashViewerApp", targets: ["StashViewerApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "StashViewerApp",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios")
            ],
            path: ".",
            exclude: [
                "Scripts",
                "Resources",
                "GraphQL/schema.graphqls"
            ],
            sources: [
                "Sources/StashViewerApp",
                "Network",
                "Views",
                "Models",
                "GraphQL"
            ]
        ),
        .testTarget(
            name: "StashViewerAppTests",
            dependencies: ["StashViewerApp"],
            path: "Tests"
        )
    ]
)
