//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit

/// A HealthKit Quantity Sample that represents data using a single numerical value and unit.
struct HkQuantitySample<T>: Codable where T: Numeric, T: Codable {
    let quantityType: String
    let unitValue: UnitValue<T>
    let effectiveTimeFrame: TimeInterval
}
