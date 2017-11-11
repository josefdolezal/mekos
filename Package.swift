// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "mekos",
    products: [
        .executable(
            name: "mekos",
            targets: ["mekos"]),
        .library(
            name: "MekosFramework",
            targets: ["MekosFramework"])
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/kylef/PathKit.git", .upToNextMinor(from: "0.8.0")),
    ],
    targets: [
        .target(
            name: "mekos",
            dependencies: ["MekosFramework", "PathKit"]),
        .target(
            name: "MekosFramework",
            dependencies: ["Yams", "PathKit"])
    ]
)
