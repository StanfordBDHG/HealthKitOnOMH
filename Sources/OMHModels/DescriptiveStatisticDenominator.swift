//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// An enumeration representing the denominator of the descriptive statistic when the measure has an implicit duration.
public enum DescriptiveStatisticDenominator: String, Codable {
    case d = "d"
    case wk = "wk"
    case Mo = "Mo"
    case episode = "episode"
    case meal = "meal"
    case session = "session"
}
