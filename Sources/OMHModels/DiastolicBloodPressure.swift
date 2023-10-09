//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


public struct DiastolicBloodPressure: Schema, Codable, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "diastolic-blood-pressure", version: "1.0")

    var value: Double
    let unit: BloodPressureUnit


    init(value: Double, unit: BloodPressureUnit = .mmHg) {
        self.value = value
        self.unit = unit
    }
}
