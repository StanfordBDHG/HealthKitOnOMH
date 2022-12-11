//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

open class BloodGlucose: Codable {
    public var bloodGlucose: UnitValue<Double>
    public var effectiveTimeFrame: TimeInterval
    public var specimenSource: String?
    public var temporalRelationshipToMeal: TemporalRelationshipToMeal?
    public var temporalRelationshipToSleep: TemporalRelationshipToSleep?
    public var descriptiveStatistic: DescriptiveStatistic?

    private enum CodingKeys: String, CodingKey {
        case bloodGlucose
        case effectiveTimeFrame
        case specimenSource
        case temporalRelationshipToMeal
        case temporalRelationshipToSleep
        case descriptiveStatistic
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.bloodGlucose = try container.decode(
            UnitValue<Double>.self,
            forKey: .bloodGlucose
        )
        self.effectiveTimeFrame = try container.decode(
            TimeInterval.self,
            forKey: .effectiveTimeFrame
        )
        self.specimenSource = try container.decode(
            String.self,
            forKey: .specimenSource
        )
        self.temporalRelationshipToMeal = try container.decodeIfPresent(
            TemporalRelationshipToMeal.self,
            forKey: .temporalRelationshipToMeal
        )
        self.temporalRelationshipToSleep = try container.decodeIfPresent(
            TemporalRelationshipToSleep.self,
            forKey: .temporalRelationshipToSleep
        )
        self.descriptiveStatistic = try container.decodeIfPresent(
            DescriptiveStatistic.self,
            forKey: .descriptiveStatistic
        )
    }

    public required init (
        bloodGlucose: UnitValue<Double>,
        effectiveTimeFrame: TimeInterval,
        specimenSource: String? = nil,
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(bloodGlucose, forKey: .bloodGlucose)
        try container.encode(effectiveTimeFrame, forKey: .effectiveTimeFrame)
        try container.encodeIfPresent(specimenSource, forKey: .specimenSource)
        try container.encodeIfPresent(temporalRelationshipToMeal, forKey: .temporalRelationshipToMeal)
        try container.encodeIfPresent(temporalRelationshipToSleep, forKey: .temporalRelationshipToSleep)
        try container.encodeIfPresent(descriptiveStatistic, forKey: .descriptiveStatistic)
    }
}
