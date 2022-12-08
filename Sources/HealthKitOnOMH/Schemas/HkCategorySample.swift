//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit

/// A generic OMH schema that represents a HealthKit category sample which describes categorical values
struct HkCategorySample: Codable {
    let categoryType: String
    let categoryValue: String
    let effectiveTimeFrame: TimeInterval
}
