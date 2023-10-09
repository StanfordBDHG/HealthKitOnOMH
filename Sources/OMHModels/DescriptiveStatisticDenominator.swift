//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// An enumeration representing the denominator of the descriptive statistic when the measure has an implicit duration.
// swiftlint:disable identifier_name
// We disable this rule because we must use case names as defined by Open mHealth.
public enum DescriptiveStatisticDenominator: String, Codable {
    case d
    case wk
    case Mo
    case episode
    case meal
    case session
}
