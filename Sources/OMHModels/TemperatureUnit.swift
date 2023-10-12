//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// A type representing a value paired with a unit specific to temperature measurements
public typealias TemperatureUnitValue = TypedUnitValue<TemperatureUnit>

public enum TemperatureUnit: String, UnitProtocol {
    // swiftlint:disable identifier_name
    // We disable this rule because we must use case names as defined by Open mHealth.
    case K
    case F
    case C
}
