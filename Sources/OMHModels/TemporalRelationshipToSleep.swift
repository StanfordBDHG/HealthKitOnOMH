//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Represents the temporal relationship of a clinical measure or assessment to sleep
public enum TemporalRelationshipToSleep: String, Codable {
    case beforeSleeping = "before sleeping"
    case duringSleep = "during sleep"
    case onWaking = "on waking"
}
