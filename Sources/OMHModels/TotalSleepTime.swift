//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


/// Total amount of time spent asleep
/// Generated from Open mHealth `omh:total-sleep-time:1.0` (https://www.openmhealth.org/schemas/omh_total-sleep-time/)
public struct TotalSleepTime: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "total-sleep-time", version: "1.0")
    
    /// The total amount of time spent asleep
    public var totalSleepTime: DurationUnitValue
    
    /// The time frame corresponding to this measurement
    public var effectiveTimeFrame: TimeFrame
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    /// The denominator of the descriptive statistic when the measures has an implicit duration
    public var descriptiveStatisticDenominator: DescriptiveStatisticDenominator?
    
    
    public init(
        totalSleepTime: DurationUnitValue,
        effectiveTimeFrame: TimeFrame,
        descriptiveStatistic: DescriptiveStatistic? = nil,
        descriptiveStatisticDenominator: DescriptiveStatisticDenominator? = nil
    ) {
        self.totalSleepTime = totalSleepTime
        self.effectiveTimeFrame = effectiveTimeFrame
        self.descriptiveStatistic = descriptiveStatistic
        self.descriptiveStatisticDenominator = descriptiveStatisticDenominator
    }
}
