// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APIClient",
    products: [
        .library(
            name: "APIClient",
            targets: ["APIClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "APIClient",
            dependencies: []),
        .testTarget(
            name: "APIClientTests",
            dependencies: ["APIClient"]),
    ]
)
