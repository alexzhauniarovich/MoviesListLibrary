// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesListLibrary",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MoviesListLibrary",
            targets: ["MoviesListLibrary"]),
    ],
    dependencies: [
        .package(url: "../Presentation", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MoviesListLibrary",
            dependencies: []),
        .testTarget(
            name: "MoviesListLibraryTests",
            dependencies: ["MoviesListLibrary"]),
    ]
)
