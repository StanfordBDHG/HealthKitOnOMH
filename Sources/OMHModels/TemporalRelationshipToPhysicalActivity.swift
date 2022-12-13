//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Represents the temporal relationship of a clinical measure or assessment to physical activity.
public enum TemporalRelationshipToPhysicalActivity: String, Codable {
    case atRest = "at rest"
    case active = "active"
    case beforeExercise = "before exercise"
    case afterExercise = "after exercise"
    case duringExercise = "during exercise"
}
