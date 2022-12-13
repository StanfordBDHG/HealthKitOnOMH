//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


public struct BloodGlucose: Schema {
    public static let schemaId = SchemaId(namespace: .omh, name: "blood-glucose", version: "3.0")
    
    
    public var bloodGlucose: UnitValue<Double>
    public var effectiveTimeFrame: TimeInterval
    public var specimenSource: SpecimenSource?
    public var temporalRelationshipToMeal: TemporalRelationshipToMeal?
    public var temporalRelationshipToSleep: TemporalRelationshipToSleep?
    public var descriptiveStatistic: DescriptiveStatistic?
    
    
    public init (
        bloodGlucose: UnitValue<Double>,
        effectiveTimeFrame: TimeInterval,
        specimenSource: SpecimenSource? = nil,
        temporalRelationshipToMeal: TemporalRelationshipToMeal? = nil,
        temporalRelationshipToSleep: TemporalRelationshipToSleep? = nil,
        descriptiveStatistic: DescriptiveStatistic? = nil
    ) {
        self.bloodGlucose = bloodGlucose
        self.effectiveTimeFrame = effectiveTimeFrame
        self.specimenSource = specimenSource
        self.temporalRelationshipToMeal = temporalRelationshipToMeal
        self.temporalRelationshipToSleep = temporalRelationshipToSleep
        self.descriptiveStatistic = descriptiveStatistic
    }
}
