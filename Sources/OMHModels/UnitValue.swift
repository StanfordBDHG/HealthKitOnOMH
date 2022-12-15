//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Represents a numerical value with a unit of measure.
/// Generated from Open mHealth `omh:unit-value:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_unit-value)
public struct UnitValue<T>: Codable where T: Numeric & Codable {
    /// String representing a unit drawn from UCUM (Unified Code for Units of Measure).
    public var unit: String

    /// A numeric value
    public var value: T
    
    
    public init(
        unit: String,
        value: T
    ) {
        self.unit = unit
        self.value = value
    }
}
