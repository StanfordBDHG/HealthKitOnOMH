//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

/// Represents a numerical value with a unit of measure.
/// Allowed units are drawn from HL7's UCUM (Unified Code for Units of Measure).
open class UnitValue<T>: Codable where T: Numeric, T: Codable {
    public var unit: String
    public var value: T

    public init(
        unit: String,
        value: T
    ) {
        self.unit = unit
        self.value = value
    }
}
