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
    
    func testTimeIntervalComparisons() {
        guard let startDate1 = Calendar.current.date(from: DateComponents(year: 2022, month: 10, day: 1, hour: 12)) else {
            XCTFail("Failed to create startDate1.")
            return
        }
        
        guard let endDate1 = Calendar.current.date(byAdding: .day, value: 1, to: startDate1) else {
            XCTFail("Failed to create endDate1.")
            return
        }
        
        let interval1 = TimeInterval(startDateTime: startDate1, endDateTime: endDate1)
        
        guard let endDate2 = Calendar.current.date(byAdding: .hour, value: 2, to: startDate1) else {
            XCTFail("Failed to create endDate2.")
            return
        }
        
        let interval2 = TimeInterval(startDateTime: startDate1, endDateTime: endDate2)
        
        XCTAssertTrue(interval1 > interval2, "Interval1 should be greater than interval2 based on endDateTime.")
        XCTAssertTrue(interval2 < interval1, "Interval2 should be less than interval1 based on endDateTime.")
        
        guard let startDate3 = Calendar.current.date(byAdding: .day, value: -1, to: startDate1) else {
            XCTFail("Failed to create startDate3.")
            return
        }
        
        let interval3 = TimeInterval(startDateTime: startDate3, endDateTime: endDate1)
        
        XCTAssertTrue(interval1 > interval3, "Interval1 should be greater than interval3 based on startDateTime.")
        XCTAssertTrue(interval3 < interval1, "Interval3 should be less than interval1 based on startDateTime.")
        
        guard let endDate4 = Calendar.current.date(byAdding: .hour, value: -2, to: endDate1) else {
            XCTFail("Failed to create endDate4.")
            return
        }
        
        let interval4 = TimeInterval(startDateTime: startDate1, endDateTime: endDate4)
        
        XCTAssertTrue(interval4 < interval1, "Interval4 should be less than interval1 based on endDateTime.")
        XCTAssertTrue(interval1 > interval4, "Interval1 should be greater than interval4 based on endDateTime.")
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

}
