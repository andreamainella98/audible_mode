// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "audible_mode",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "audible-mode", targets: ["audible_mode"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/akramhussein/Mute.git", from: "0.6.0")
    ],
    targets: [
        .target(
            name: "audible_mode",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "Mute", package: "Mute")
            ]
        )
    ]
)
