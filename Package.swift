// swift-tools-version:5.2

/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "walkInk",
    products: [
        .library(name: "walkInk", targets: ["walkInk"]),
        .executable(name: "walkInk-cli", targets: ["walkInkCLI"])
    ],
    targets: [
        .target(name: "walkInk"),
        .target(name: "walkInkCLI", dependencies: ["walkInk"]),
        .testTarget(name: "walkInkTests", dependencies: ["walkInk"])
    ]
)
