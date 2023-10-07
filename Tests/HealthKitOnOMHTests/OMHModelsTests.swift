//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import OMHModels
import XCTest


final class OMHModelsTests: XCTestCase {
    var startDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 0) // Date Stanford University opened (https://www.stanford.edu/about/history/)
            return try XCTUnwrap(Calendar.current.date(from: dateComponents))
        }
    }
    
    var endDate: Date {
        get throws {
            let dateComponents = DateComponents(year: 1891, month: 10, day: 1, hour: 12, minute: 0, second: 42)
            return try XCTUnwrap(Calendar.current.date(from: dateComponents))
        }
    }
    
    func testTimeInterval() throws {
        let timeFrame1 = TimeInterval(
            startDateTime: try startDate,
            endDateTime: try endDate
        )
        let timeFrame2 = TimeInterval(
            startDateTime: try startDate,
            endDateTime: try endDate
        )

        XCTAssertEqual(timeFrame1, timeFrame2)
    }
    
    func testBloodGlucose() throws {
        let timeFrame = TimeInterval(startDateTime: try startDate, endDateTime: try endDate)
        
        let beforeBreakfastGlucose = BloodGlucose(
            bloodGlucose: UnitValue(unit: "mg/dL", value: 80),
            effectiveTimeFrame: timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToMeal: TemporalRelationshipToMeal.beforeBreakfast
        )
        
        XCTAssertEqual(beforeBreakfastGlucose.bloodGlucose.value, 80)
        XCTAssertEqual(beforeBreakfastGlucose.temporalRelationshipToMeal, TemporalRelationshipToMeal.beforeBreakfast)
        XCTAssertEqual(beforeBreakfastGlucose.specimenSource, SpecimenSource.capillaryBlood)
        XCTAssertEqual(beforeBreakfastGlucose.effectiveTimeFrame, timeFrame)
        
        let duringSleepBloodGlucose = BloodGlucose(
            bloodGlucose: UnitValue(unit: "mg/dL", value: 70),
            effectiveTimeFrame: timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToSleep: TemporalRelationshipToSleep.duringSleep
        )
        
        XCTAssertEqual(duringSleepBloodGlucose.bloodGlucose.value, 70)
        XCTAssertEqual(duringSleepBloodGlucose.temporalRelationshipToSleep, TemporalRelationshipToSleep.duringSleep)
        XCTAssertEqual(duringSleepBloodGlucose.specimenSource, SpecimenSource.capillaryBlood)
        XCTAssertEqual(duringSleepBloodGlucose.effectiveTimeFrame, timeFrame)
        
        let averageBloodGlucose = BloodGlucose(
            bloodGlucose: UnitValue(unit: "mg/dL", value: 120),
            effectiveTimeFrame: timeFrame,
            descriptiveStatistic: DescriptiveStatistic.average
        )
        
        XCTAssertEqual(averageBloodGlucose.bloodGlucose.value, 120)
        XCTAssertEqual(averageBloodGlucose.descriptiveStatistic, DescriptiveStatistic.average)
        XCTAssertEqual(averageBloodGlucose.effectiveTimeFrame, timeFrame)
    }
    
    func testHeartRate() throws {
        let timeFrame = TimeInterval(startDateTime: try startDate, endDateTime: try endDate)
        
        let heartRateOnWaking = HeartRate(
            heartRate: UnitValue(unit: "beats/min", value: 50),
            effectiveTimeFrame: timeFrame,
            temporalRelationshipToSleep: .onWaking
        )
        
        XCTAssertEqual(50, heartRateOnWaking.heartRate.value)
        XCTAssertEqual(heartRateOnWaking.temporalRelationshipToSleep, TemporalRelationshipToSleep.onWaking)
        
        let heartRateWithActivity = HeartRate(
            heartRate: UnitValue(unit: "beats/min", value: 120),
            effectiveTimeFrame: timeFrame,
            temporalRelationshipToPhysicalActivity: .duringExercise
        )
        
        XCTAssertEqual(120, heartRateWithActivity.heartRate.value)
        XCTAssertEqual(heartRateWithActivity.temporalRelationshipToPhysicalActivity, .duringExercise)
        XCTAssertEqual(heartRateWithActivity.effectiveTimeFrame, timeFrame)
        
        let heartRateWithDescriptiveStatistics = HeartRate(
            heartRate: UnitValue(unit: "beats/min", value: 50),
            effectiveTimeFrame: timeFrame,
            descriptiveStatistic: .minimum
        )
        
        XCTAssertEqual(50, heartRateWithDescriptiveStatistics.heartRate.value)
        XCTAssertEqual(heartRateWithDescriptiveStatistics.descriptiveStatistic, .minimum)
        XCTAssertEqual(heartRateWithDescriptiveStatistics.effectiveTimeFrame, timeFrame)
    }
    
    func testStepCount() throws {
        let timeFrame = TimeInterval(startDateTime: try startDate, endDateTime: try endDate)
        
        let simpleStepCount = StepCount(
            stepCount: UnitValue(unit: "count", value: 5000),
            effectiveTimeFrame: timeFrame
        )
        
        XCTAssertEqual(5000, simpleStepCount.stepCount.value)
        XCTAssertEqual(simpleStepCount.effectiveTimeFrame, timeFrame)
        XCTAssertNil(simpleStepCount.descriptiveStatistic)
        XCTAssertNil(simpleStepCount.descriptiveStatisticDenominator)
        
        let averageStepCount = StepCount(
            stepCount: UnitValue(unit: "count", value: 6500),
            effectiveTimeFrame: timeFrame,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        
        XCTAssertEqual(6500, averageStepCount.stepCount.value)
        XCTAssertEqual(averageStepCount.effectiveTimeFrame, timeFrame)
        XCTAssertEqual(averageStepCount.descriptiveStatistic, .average)
        XCTAssertEqual(averageStepCount.descriptiveStatisticDenominator, .d)
    }

    func testBodyWeight() throws {
        let timeFrame = TimeInterval(startDateTime: try startDate, endDateTime: try endDate)

        let simpleBodyWeight = BodyWeight(
            bodyWeight: UnitValue(unit: "kg", value: 100),
            effectiveTimeFrame: timeFrame
        )

        XCTAssertEqual(simpleBodyWeight.bodyWeight.value, 100)
        XCTAssertEqual(simpleBodyWeight.bodyWeight.unit, "kg")
        XCTAssertEqual(simpleBodyWeight.effectiveTimeFrame, timeFrame)

        let averageBodyWeight = BodyWeight(
            bodyWeight: UnitValue(unit: "kg", value: 100),
            effectiveTimeFrame: timeFrame,
            descriptiveStatistic: .average
        )

        XCTAssertEqual(averageBodyWeight.descriptiveStatistic, .average)
    }

    func testBodyHeight() throws {
        let timeFrame = TimeInterval(startDateTime: try startDate, endDateTime: try endDate)

        let simpleBodyHeight = BodyHeight(
            bodyHeight: UnitValue(unit: "cm", value: 180),
            effectiveTimeFrame: timeFrame
        )

        XCTAssertEqual(simpleBodyHeight.bodyHeight.value, 180)
        XCTAssertEqual(simpleBodyHeight.bodyHeight.unit, "cm")
        XCTAssertEqual(simpleBodyHeight.effectiveTimeFrame, timeFrame)

        let averageBodyHeight = BodyHeight(
            bodyHeight: UnitValue(unit: "cm", value: 200),
            effectiveTimeFrame: timeFrame,
            descriptiveStatistic: .maximum
        )

        XCTAssertEqual(averageBodyHeight.descriptiveStatistic, .maximum)
    }
}
