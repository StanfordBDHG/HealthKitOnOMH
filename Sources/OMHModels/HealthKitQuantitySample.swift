//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A HealthKit Quantity Sample that represents data using a single numerical value and unit.
/// Generated from Open mHealth `granola:hk-quantity-sample:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/granola_hk-quantity-sample)
public struct HealthKitQuantitySample<T>: Schema where T: Numeric & Codable {
    /// An Open mHealth schema identifier
    public static var schemaId: SchemaId {
        SchemaId(namespace: .granola, name: "hk-quantity-sample", version: "1.0")
    }
    
    /// A string representation of the HKQuantityType
    public var quantityType: String

    /// The associated UnitValue for this HealthKitQuantitySample
    public var unitValue: UnitValue<T>

    /// The associated TimeInterval for this HealthKitQuantitySample
    public var effectiveTimeFrame: TimeInterval
    
    
    public init (
        quantityType: String,
        unitValue: UnitValue<T>,
        effectiveTimeFrame: TimeInterval
    ) {
        self.quantityType = quantityType
        self.unitValue = unitValue
        self.effectiveTimeFrame = effectiveTimeFrame
    }
}
