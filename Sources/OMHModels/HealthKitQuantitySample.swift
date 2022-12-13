//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A HealthKit Quantity Sample that represents data using a single numerical value and unit.
public struct HealthKitQuantitySample<T>: Schema where T: Numeric & Codable {
    static public var schemaId: SchemaId {
        SchemaId(namespace: .omh, name: "HealthKitQuantitySample<\(String(describing: T.self))>", version: "2.0")
    }
    
    
    public var quantityType: String
    public var unitValue: UnitValue<T>
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
