//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


public struct AcquisitionProvenance: Sendable, Codable {
    public var sourceName: String
    public var sourceCreationDateTime: Date?
    public var modality: Modality?
    
    
    init(
        sourceName: String,
        sourceCreationDateTime: Date? = nil,
        modality: Modality? = nil
    ) {
        self.sourceName = sourceName
        self.sourceCreationDateTime = sourceCreationDateTime
        self.modality = modality
    }
}
