//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


public struct SystolicBloodPressure: Schema, Codable, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "systolic-blood-pressure", version: "1.0")

    /// The blood pressure value
    public var value: Double

    /// The blood pressure unit
    public var unit: BloodPressureUnit


    init(value: Double, unit: BloodPressureUnit = .mmHg) {
        self.value = value
        self.unit = unit
    }
}
