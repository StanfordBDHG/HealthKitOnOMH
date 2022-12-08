// swift-tools-version:5.7

//
// This source file is part of the HealthKitOnOMH open source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "HealthKitOnOMH",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "HealthKitOnOMH", targets: ["HealthKitOnOMH"])
    ],
    targets: [
        .target(
            name: "HealthKitOnOMH"
        ),
        .testTarget(
            name: "HealthKitOnOMHTests",
            dependencies: [
                .target(name: "HealthKitOnOMH")
            ]
        )
    ]
)
