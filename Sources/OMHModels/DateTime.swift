//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Generated from Open mHealth `omh:date-time:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_date-time)
public struct DateTime: Schema, Equatable {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "date-time", version: "1.0")
    
    private static let formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()

    let value: String // The value should be in ISO8601 format as per the schema.


    public init(date: Date) {
        self.value = DateTime.formatter.string(from: date)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }
}
