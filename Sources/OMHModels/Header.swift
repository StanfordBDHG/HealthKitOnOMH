//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// This schema represents the header of a data point.
/// Generated from Open mHealth omh:header:1.2 (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_header)
public struct Header: Codable, Sendable {
    /// The identifier of this data point - should be a globally unique value.
    public var id: String

    /// The date time this data point was created on the system where data is stored.
    public var creationDateTime: Date

    /// The schema identifier of the body of the data point.
    public var schemaId: SchemaId

    /// An `AcquisitionProvenance` provides metadata regarding the origin of the data
    public var acquisitionProvenance: AcquisitionProvenance?

    /// The user this data point belongs to.
    public var userId: String?

    
    public init (
        id: String,
        creationDateTime: Date,
        schemaId: SchemaId,
        acquisitionProvenance: AcquisitionProvenance? = nil,
        userId: String? = nil
    ) {
        self.id = id
        self.creationDateTime = creationDateTime
        self.schemaId = schemaId
        self.acquisitionProvenance = acquisitionProvenance
        self.userId = userId
    }
}
