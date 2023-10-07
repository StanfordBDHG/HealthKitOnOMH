//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


public struct HeartRate: Schema {
    /// The Open mHealth schema identifier
    public static let schemaId = SchemaId(namespace: .omh, name: "heart-rate", version: "2.0")
    
    /// The heart rate measurement as a `UnitValue` containing a double value and unit
    public var heartRate: UnitValue<Double>
    
    /// The time interval corresponding to this measurement
    public var effectiveTimeFrame: TimeInterval
    
    /// The relationship of this measurement to sleep (e.g. on waking)
    public var temporalRelationshipToSleep: TemporalRelationshipToSleep?
    
    /// The relationship of this measurement to physical activity
    public var temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity?
    
    /// If the value in this data point is a descriptive statistic rather than a single measurement (e.g. minimum, average, median)
    /// this property should contain the specific type of descriptive statistic
    public var descriptiveStatistic: DescriptiveStatistic?
    
    
    public init(
        heartRate: UnitValue<Double>,
        effectiveTimeFrame: TimeInterval,
        temporalRelationshipToSleep: TemporalRelationshipToSleep? = nil,
        temporalRelationshipToPhysicalActivity: TemporalRelationshipToPhysicalActivity? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.heartRate = heartRate
        self.effectiveTimeFrame = effectiveTimeFrame
        self.temporalRelationshipToSleep = temporalRelationshipToSleep
        self.temporalRelationshipToPhysicalActivity = temporalRelationshipToPhysicalActivity
        self.descriptiveStatistic = descriptiveStatistic
    }
}
