// swift-tools-version:5.8

//
// This source file is part of the HealthKitOnOMH open source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import class Foundation.ProcessInfo
import PackageDescription


#if swift(<6)
let swiftConcurrency: SwiftSetting = .enableExperimentalFeature("StrictConcurrency")
#else
let swiftConcurrency: SwiftSetting = .enableUpcomingFeature("StrictConcurrency")
#endif


let package = Package(
    name: "HealthKitOnOMH",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "HealthKitOnOMH", targets: ["HealthKitOnOMH"])
    ],
    dependencies: [
        .package(url: "https://github.com/StanfordBDHG/OMHModels.git", .upToNextMajor(from: "0.1.0"))
    ] + swiftLintPackage(),
    targets: [
        .target(
            name: "HealthKitOnOMH",
            dependencies: [
                .product(name: "OMHModels", package: "OMHModels")
            ],
            swiftSettings: [
                swiftConcurrency
            ],
            plugins: [] + swiftLintPlugin()
        ),
        .testTarget(
            name: "HealthKitOnOMHTests",
            dependencies: [
                .target(name: "HealthKitOnOMH")
            ],
            swiftSettings: [
                swiftConcurrency
            ],
            plugins: [] + swiftLintPlugin()
        )
    ]
)


func swiftLintPlugin() -> [Target.PluginUsage] {
    // Fully quit Xcode and open again with `open --env SPEZI_DEVELOPMENT_SWIFTLINT /Applications/Xcode.app`
    if ProcessInfo.processInfo.environment["SPEZI_DEVELOPMENT_SWIFTLINT"] != nil {
        [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
    } else {
        []
    }
}

func swiftLintPackage() -> [PackageDescription.Package.Dependency] {
    if ProcessInfo.processInfo.environment["SPEZI_DEVELOPMENT_SWIFTLINT"] != nil {
        [.package(url: "https://github.com/realm/SwiftLint.git", from: "0.55.1")]
    } else {
        []
    }
}
