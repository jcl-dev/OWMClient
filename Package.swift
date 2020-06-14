// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OWMClient",
    products: [
        .library(
            name: "OWMClient",
            targets: ["OWMClient"]),
        .executable(
            name: "owm",
            targets: ["owm"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "OWMClient",
            dependencies: ["SwiftyJSON"]),
        .target(
            name: "owm",
            dependencies: ["OWMClient"]),
        .testTarget(
            name: "OWMClientTests",
            dependencies: ["OWMClient"]),
    ]
)
