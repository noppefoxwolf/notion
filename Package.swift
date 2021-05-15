// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "notion",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "notion",
            targets: ["notion"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
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
