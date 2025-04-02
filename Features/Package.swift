// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "MainTabView",
            targets: ["MainTabView"]),
    ],
    dependencies: [
        .package(path: "../Core"),
    ],
    targets: [
        .target(
            name: "MainTabView",
            dependencies: ["Discovery", "Research", "Booking"]
        ),
        .target(
            name: "Discovery",
            dependencies: [
                .product(name: "DataLoader", package: "Core"),
                .product(name: "RestAPI", package: "Core")
            ]
        ),
        .target(
            name: "Research",
            dependencies: [
                .product(name: "DataLoader", package: "Core"),
                .product(name: "RestAPI", package: "Core")
            ]
        ),
        .target(
            name: "Booking",
            dependencies: [
                .product(name: "DataLoader", package: "Core"),
                .product(name: "RestAPI", package: "Core")
            ]
        ),
    ]
)
