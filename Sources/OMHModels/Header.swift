//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


public struct Header: Codable, Sendable {
    public var id: String
    public var creationDateTime: Date
    public var schemaId: SchemaId
    public var acquisitionProvenance: AcquisitionProvenance?
    
    
    public init (
        id: String,
        creationDateTime: Date,
        schemaId: SchemaId,
        acquisitionProvenance: AcquisitionProvenance? = nil
    ) {
        self.id = id
        self.creationDateTime = creationDateTime
        self.schemaId = schemaId
        self.acquisitionProvenance = acquisitionProvenance
    }
}
