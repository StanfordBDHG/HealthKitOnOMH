//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


import Foundation

open class AcquisitionProvenance: Codable {
    public var sourceName: String
    public var sourceCreationDateTime: Date?
    public var modality: Modality?
}
