//
// This source file is part of the TemplatePackage open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import HealthKitOnOMH
import SwiftUI


@main
struct UITestsApp: App {
    var body: some Scene {
        WindowGroup {
            Text(HealthKitOnOMH().stanford)
        }
    }
}
