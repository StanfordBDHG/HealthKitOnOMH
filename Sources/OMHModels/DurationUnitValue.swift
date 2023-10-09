//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// Generated from Open mHealth `omh:duration-unit-value:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_duration-unit-value)
public struct DurationUnitValue: Codable, Equatable {
    public var unit: TimeUnit
    public var value: Double

    public static func == (lhs: DurationUnitValue, rhs: DurationUnitValue) -> Bool {
        lhs.unit == rhs.unit &&
        lhs.value == rhs.value
    }
}
