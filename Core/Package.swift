// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "DataLoader",
            targets: ["DataLoader"]
        ),
        .library(
            name: "RestAPI",
            targets: ["RestAPI"]
        ),
    ],
    targets: [
        .target(name: "DataLoader"),
        .target(
            name: "RestAPI",
            dependencies: ["DataLoader"],
            resources: [
                .copy("ResourcesQA/rank.json"),
                .copy("ResourcesQA/movies.json"),
                .copy("ResourcesQA/movieDetails.json"),
            ]
        ),
    ]
)
