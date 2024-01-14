// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "LoggingCamp",
    products: [
        .library(
            name: "LoggingCamp",
            targets: ["LoggingCamp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DariuszGulbicki/Colorizer", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "LoggingCamp",
            dependencies: [.product(name: "Colorizer", package: "colorizer")]),
        .testTarget(
            name: "LoggingCampTests",
            dependencies: ["LoggingCamp"]),
    ]
)
