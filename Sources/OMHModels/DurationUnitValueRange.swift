//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Generated from IEEE 1752.1 `duration-unit-value-range:1.0` (https://w3id.org/ieee/ieee-1752-schema/duration-unit-value-range.json)
public struct DurationUnitValueRange: Schema, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .ieee, name: "duration-unit-value-range", version: "1.0")
    
    public var unit: TimeUnit
    public var value: Double
}
