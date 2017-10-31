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
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/kylef/PathKit.git", .upToNextMinor(from: "0.7.0")),
        .package(url: "https://github.com/kylef/Commander.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "mekos",
            dependencies: ["MekosFramework", "Commander", "PathKit"]),
        .target(
            name: "MekosFramework",
            dependencies: ["Yams", "PathKit"])
    ]
)
