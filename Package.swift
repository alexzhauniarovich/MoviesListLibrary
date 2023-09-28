// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesListLibrary",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MoviesListLibrary",
            targets: ["MoviesListLibrary"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MoviesListLibrary",
            dependencies: []),
        .testTarget(
            name: "MoviesListLibraryTests",
            dependencies: ["MoviesListLibrary"]),
    ]
)
