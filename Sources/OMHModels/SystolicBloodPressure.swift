//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


public struct SystolicBloodPressure: Codable, Equatable {
    var value: Double
    let unit: BloodPressureUnit
    

    init(value: Double, unit: BloodPressureUnit = .mmHg) {
        self.value = value
        self.unit = unit
    }
}
