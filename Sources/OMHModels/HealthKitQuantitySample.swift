//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit

/// A HealthKit Quantity Sample that represents data using a single numerical value and unit.
open class HealthKitQuantitySample<T>: Schema where T: Numeric, T: Codable {
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
        super.init(schemaId: SchemaId(namespace: .omh, name: "heart-rate", version: "2.0"))
    }
}
