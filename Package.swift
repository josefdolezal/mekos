// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "mekos",
    targets: [
        Target(name: "mekos", dependencies: ["MekosFramework"]),
        Target(name: "MekosFramework")
    ],
    dependencies: [
        .Package(url: "https://github.com/jpsim/Yams.git", majorVersion: 0),
        .Package(url: "https://github.com/kylef/PathKit.git", majorVersion: 0)
    ]
)
