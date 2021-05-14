// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "notion",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(
            name: "notion",
            targets: ["notion"]),
    ],
    targets: [
        .target(
            name: "notion",
            path: "notion"
        ),
    ]
)