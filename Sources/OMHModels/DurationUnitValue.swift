//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// Generated from IEEE 1752.1 `duration-unit-value:1.0` (https://w3id.org/ieee/ieee-1752-schema/duration-unit-value.json)
public struct DurationUnitValue: Schema, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "duration-unit-value", version: "1.0")
    
    public var unit: TimeUnit
    public var value: Double

    public static func == (lhs: DurationUnitValue, rhs: DurationUnitValue) -> Bool {
        lhs.unit == rhs.unit &&
        lhs.value == rhs.value
    }
}
