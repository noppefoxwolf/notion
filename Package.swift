// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "notion",
    products: [
        .library(
            name: "notion",
            targets: ["notion"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "notion",
            dependencies: ["Object", "API"]
        ),
        .target(name: "Object"),
        .testTarget(
            name: "ObjectTests",
            dependencies: ["Object"]),
        .target(
            name: "API",
            dependencies: ["Object"]
        ),
    ]
)
