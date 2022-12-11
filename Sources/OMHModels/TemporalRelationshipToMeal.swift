//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// Represents the temporal relationship of a clinical measure or assessment to meals
public enum TemporalRelationshipToMeal: String, Codable {
    case fasting = "fasting"
    case notFasting = "not fasting"
    case beforeMeal = "before meal"
    case afterMeal = "after meal"
    case beforeBreakfast = "before breakfast"
    case afterBreakfast = "after breakfast"
    case beforeLunch = "before lunch"
    case afterLunch = "after lunch"
    case beforeDinner = "before dinner"
    case afterDinner = "after dinner"
    case twoHoursPostprandial = "2 hours postprandial"
    case withMeal = "with meal"
    case withFood = "with food"
}
