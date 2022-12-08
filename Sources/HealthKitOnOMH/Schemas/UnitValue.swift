//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

/// Represents a numerical value with a unit of measure.
/// Allowed units are drawn from HL7's UCUM (Unified Code for Units of Measure).
struct UnitValue<T>: Codable where T: Numeric, T: Codable {
    let unit: String
    let value: T
}
