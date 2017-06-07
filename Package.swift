// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "mekos",
    targets: [
        Target(name: "mekos", dependencies: ["MekosFramework"]),
        Target(name: "MekosFramework")
    ]
)
