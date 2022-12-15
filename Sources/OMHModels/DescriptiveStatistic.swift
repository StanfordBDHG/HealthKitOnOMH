//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// An enumeration representing different types of stastical measures that can be represented in data points
public enum DescriptiveStatistic: String, Codable {
    case average = "average"
    case count = "count"
    case maximum = "maximum"
    case median = "median"
    case minimum = "minimum"
    case standardDeviation = "standard deviation"
    case sum = "sum"
    case variance = "variance"
    case twentiethPercentile = "20th percentile"
    case eightiethPercentile = "80th percentile"
    case lowerQuartile = "lower quartile"
    case upperQuartile = "upper quartile"
    case quartileDeviation = "quartile deviation"
    case firstQuintile = "1st quintile"
    case secondQuintile = "2nd quintile"
    case thirdQuintile = "3rd quintile"
    case fourthQuintile = "4th quintile"
}
