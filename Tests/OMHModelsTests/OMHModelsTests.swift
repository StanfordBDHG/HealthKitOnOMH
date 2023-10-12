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

    var timeFrame: TimeFrame {
        get throws {
            TimeFrame(timeInterval: TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate)))
        }
    }

    func testBloodGlucose() throws {
        let beforeBreakfastGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 80),
            effectiveTimeFrame: try timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToMeal: TemporalRelationshipToMeal.beforeBreakfast
        )
        
        XCTAssertEqual(beforeBreakfastGlucose.bloodGlucose.value, 80)
        XCTAssertEqual(beforeBreakfastGlucose.temporalRelationshipToMeal, TemporalRelationshipToMeal.beforeBreakfast)
        XCTAssertEqual(beforeBreakfastGlucose.specimenSource, SpecimenSource.capillaryBlood)
        XCTAssertEqual(beforeBreakfastGlucose.effectiveTimeFrame, try timeFrame)

        let duringSleepBloodGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 70),
            effectiveTimeFrame: try timeFrame,
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToSleep: TemporalRelationshipToSleep.duringSleep
        )
        
        XCTAssertEqual(duringSleepBloodGlucose.bloodGlucose.value, 70)
        XCTAssertEqual(duringSleepBloodGlucose.temporalRelationshipToSleep, TemporalRelationshipToSleep.duringSleep)
        XCTAssertEqual(duringSleepBloodGlucose.specimenSource, SpecimenSource.capillaryBlood)
        XCTAssertEqual(duringSleepBloodGlucose.effectiveTimeFrame, try timeFrame)

        let averageBloodGlucose = BloodGlucose(
            bloodGlucose: BloodGlucoseUnitValue(unit: .milligramsPerDeciliter, value: 120),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: DescriptiveStatistic.average
        )
        
        XCTAssertEqual(averageBloodGlucose.bloodGlucose.value, 120)
        XCTAssertEqual(averageBloodGlucose.descriptiveStatistic, DescriptiveStatistic.average)
        XCTAssertEqual(averageBloodGlucose.effectiveTimeFrame, try timeFrame)
    }
    
    func testHeartRate() throws {
        let heartRateOnWaking = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 50),
            effectiveTimeFrame: try timeFrame,
            temporalRelationshipToSleep: .onWaking
        )
        
        XCTAssertEqual(50, heartRateOnWaking.heartRate.value)
        XCTAssertEqual(heartRateOnWaking.temporalRelationshipToSleep, TemporalRelationshipToSleep.onWaking)
        
        let heartRateWithActivity = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 120),
            effectiveTimeFrame: try timeFrame,
            temporalRelationshipToPhysicalActivity: .duringExercise
        )
        
        XCTAssertEqual(120, heartRateWithActivity.heartRate.value)
        XCTAssertEqual(heartRateWithActivity.temporalRelationshipToPhysicalActivity, .duringExercise)
        XCTAssertEqual(heartRateWithActivity.effectiveTimeFrame, try timeFrame)

        let heartRateWithDescriptiveStatistics = HeartRate(
            heartRate: HeartRateUnitValue(unit: .beatsPerMinute, value: 50),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .minimum
        )
        
        XCTAssertEqual(50, heartRateWithDescriptiveStatistics.heartRate.value)
        XCTAssertEqual(heartRateWithDescriptiveStatistics.descriptiveStatistic, .minimum)
        XCTAssertEqual(heartRateWithDescriptiveStatistics.effectiveTimeFrame, try timeFrame)
    }
    
    func testStepCount() throws {
     let simpleStepCount = StepCount(
            stepCount: StepCountUnitValue(unit: .steps, value: 5000),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(5000, simpleStepCount.stepCount.value)
        XCTAssertEqual(simpleStepCount.effectiveTimeFrame, try timeFrame)
        XCTAssertNil(simpleStepCount.descriptiveStatistic)
        XCTAssertNil(simpleStepCount.descriptiveStatisticDenominator)
        
        let averageStepCount = StepCount(
            stepCount: StepCountUnitValue(unit: .steps, value: 6500),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .average,
            descriptiveStatisticDenominator: .d
        )
        
        XCTAssertEqual(6500, averageStepCount.stepCount.value)
        XCTAssertEqual(averageStepCount.effectiveTimeFrame, try timeFrame)
        XCTAssertEqual(averageStepCount.descriptiveStatistic, .average)
        XCTAssertEqual(averageStepCount.descriptiveStatisticDenominator, .d)
    }

    func testBodyWeight() throws {
        let simpleBodyWeight = BodyWeight(
            bodyWeight: MassUnitValue(unit: .kg, value: 100),
            effectiveTimeFrame: try timeFrame
        )

        XCTAssertEqual(simpleBodyWeight.bodyWeight.value, 100)
        XCTAssertEqual(simpleBodyWeight.bodyWeight.unit, .kg)
        XCTAssertEqual(simpleBodyWeight.effectiveTimeFrame, try timeFrame)

        let averageBodyWeight = BodyWeight(
            bodyWeight: MassUnitValue(unit: .kg, value: 100),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .average
        )

        XCTAssertEqual(averageBodyWeight.descriptiveStatistic, .average)
    }

    func testBodyHeight() throws {
        let simpleBodyHeight = BodyHeight(
            bodyHeight: LengthUnitValue(unit: .cm, value: 180),
            effectiveTimeFrame: try timeFrame
        )

        XCTAssertEqual(simpleBodyHeight.bodyHeight.value, 180)
        XCTAssertEqual(simpleBodyHeight.bodyHeight.unit, .cm)
        XCTAssertEqual(simpleBodyHeight.effectiveTimeFrame, try timeFrame)

        let averageBodyHeight = BodyHeight(
            bodyHeight: LengthUnitValue(unit: .cm, value: 200),
            effectiveTimeFrame: try timeFrame,
            descriptiveStatistic: .maximum
        )

        XCTAssertEqual(averageBodyHeight.descriptiveStatistic, .maximum)
    }
    
    func testBodyTemperature() throws {
        let simpleBodyTemperature = BodyTemperature(
            bodyTemperature: TemperatureUnitValue(unit: .C, value: 37),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(simpleBodyTemperature.bodyTemperature.value, 37)
        XCTAssertEqual(simpleBodyTemperature.bodyTemperature.unit, TemperatureUnit.C)
        XCTAssertEqual(simpleBodyTemperature.effectiveTimeFrame, try timeFrame)
    }
    
    func testRespiratoryRate() throws {
        let simpleRespiratoryRate = RespiratoryRate(
            respiratoryRate: RespiratoryRateUnitValue(unit: .breathsPerMinute, value: 20),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(simpleRespiratoryRate.respiratoryRate.value, 20)
        XCTAssertEqual(simpleRespiratoryRate.respiratoryRate.unit, RespiratoryRateUnit.breathsPerMinute)
        XCTAssertEqual(simpleRespiratoryRate.effectiveTimeFrame, try timeFrame)
    }
    
    func testTotalSleepTime() throws {
        let totalSleepTime = TotalSleepTime(
            totalSleepTime: DurationUnitValue(unit: .min, value: 465),
            effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(totalSleepTime.totalSleepTime.value, 465)
        XCTAssertEqual(totalSleepTime.totalSleepTime.unit, .min)
    }
    
    func testBodyFatPercentage() throws {
        let bodyFatPercentage = BodyFatPercentage(
            bodyFatPercentage: BodyFatPercentageUnitValue(unit: .percent, value: 16)
        )
        
        XCTAssertEqual(bodyFatPercentage.bodyFatPercentage.value, 16)
        XCTAssertEqual(bodyFatPercentage.bodyFatPercentage.unit, .percent)
    }
    
    func testBodyMassIndex() throws {
        let bodyMassIndex = BodyMassIndex(
            bodyMassIndex: BodyMassIndexUnitValue(unit: .kilogramsPerMeterSquared, value: 22.5), effectiveTimeFrame: try timeFrame
        )
        
        XCTAssertEqual(bodyMassIndex.bodyMassIndex.value, 22.5)
        XCTAssertEqual(bodyMassIndex.bodyMassIndex.unit, .kilogramsPerMeterSquared)
    }
    
    func testDurationUnitValue() {
        let duration1 = DurationUnitValue(
            unit: .min,
            value: 60
        )
        
        let duration2 = DurationUnitValue(
            unit: .min,
            value: 90
        )
        
        XCTAssertEqual(60, duration1.value)
        XCTAssertEqual(90, duration2.value)
        XCTAssertNotEqual(duration1, duration2)
    }
    
    func testHealthKitUnitValue() {
        let healthKitUnit =  HealthKitUnitValue(unit: HealthKitUnit(unit: "count"), value: 100)
        
        XCTAssertEqual(healthKitUnit.value, 100)
    }
    
    func testTimeIntervalwithStartDateTimeAndDuration() {
        let startDateTime = DateTime(date: .now)
        let duration = DurationUnitValue(unit: .min, value: 60)
        
        let timeInterval = TimeInterval(startDateTime: startDateTime, duration: duration)
        
        XCTAssertEqual(timeInterval.startDateTime, startDateTime)
        XCTAssertEqual(timeInterval.duration, duration)
        XCTAssertNil(timeInterval.endDateTime)
        XCTAssertNil(timeInterval.date)
        XCTAssertNil(timeInterval.partOfDay)
    }

    func testTimeIntervalWithEndDateTimeAndDuration() {
        let endDateTime = DateTime(date: .now)
        let duration = DurationUnitValue(unit: .min, value: 60)
        
        let timeInterval = TimeInterval(endDateTime: endDateTime, duration: duration)
        
        XCTAssertEqual(timeInterval.endDateTime, endDateTime)
        XCTAssertEqual(timeInterval.duration, duration)
        XCTAssertNil(timeInterval.startDateTime)
        XCTAssertNil(timeInterval.date)
        XCTAssertNil(timeInterval.partOfDay)
    }

    func testInitWithStartDateTimeAndEndDateTime() {
        let startDateTime = DateTime(date: Date(timeIntervalSince1970: 0)) // Substitute with your DateTime initialization
        let endDateTime = DateTime(date: Date(timeIntervalSince1970: 10)) // Substitute with your DateTime initialization
        
        let timeInterval = TimeInterval(startDateTime: startDateTime, endDateTime: endDateTime)
        
        XCTAssertEqual(timeInterval.startDateTime, startDateTime)
        XCTAssertEqual(timeInterval.endDateTime, endDateTime)
        XCTAssertNil(timeInterval.duration)
        XCTAssertNil(timeInterval.date)
        XCTAssertNil(timeInterval.partOfDay)
    }

    func testInitWithDateAndPartOfDay() {
        let date = Date()
        let partOfDay = PartOfDay.morning
        
        let timeInterval = TimeInterval(date: date, partOfDay: partOfDay)
        
        XCTAssertEqual(timeInterval.date, date)
        XCTAssertEqual(timeInterval.partOfDay, partOfDay)
        XCTAssertNil(timeInterval.startDateTime)
        XCTAssertNil(timeInterval.endDateTime)
        XCTAssertNil(timeInterval.duration)
    }
    
    func testTimeFrameDateTimeInitializer() {
        let sampleDateTime = DateTime(date: .now)
        let timeFrame = TimeFrame(dateTime: sampleDateTime)
        
        XCTAssertNotNil(timeFrame.dateTime)
        XCTAssertNil(timeFrame.timeInterval)
    }
    
    func testTimeFrameEquality() throws {
        let sampleDateTime = DateTime(date: .now)
        let sampleTimeInterval = TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate))

        let timeFrame1 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame2 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame3 = TimeFrame(timeInterval: sampleTimeInterval)

        XCTAssertEqual(timeFrame1, timeFrame2)
        XCTAssertNotEqual(timeFrame1, timeFrame3)
    }
    
    func testTimeFrameEncoding() throws {
        let sampleDateTime = DateTime(date: .now)
        let sampleTimeInterval = TimeInterval(startDateTime: DateTime(date: try startDate), endDateTime: DateTime(date: try endDate))

        let timeFrame1 = TimeFrame(dateTime: sampleDateTime)
        let timeFrame2 = TimeFrame(timeInterval: sampleTimeInterval)

        let encoder = JSONEncoder()

        do {
            let dateTimeData = try encoder.encode(timeFrame1)
            if let encodedString = String(data: dateTimeData, encoding: .utf8) {
                XCTAssertTrue(encodedString.contains("date_time"))
            } else {
                XCTFail("Failed to convert encoded data to string for dateTime")
            }
        } catch {
            XCTFail("Failed to encode TimeFrame for dateTime: \(error)")
        }

        do {
            let timeIntervalData = try encoder.encode(timeFrame2)
            if let encodedString = String(data: timeIntervalData, encoding: .utf8) {
                XCTAssertTrue(encodedString.contains("time_interval"))
            } else {
                XCTFail("Failed to convert encoded data to string for timeInterval")
            }
        } catch {
            XCTFail("Failed to encode TimeFrame for timeInterval: \(error)")
        }
    }
    
    func testTimeFrameDecoding() throws {
            // A time frame that consists of a single date_time
            guard let dateTimeJson = """
            {
                "date_time": "2013-02-05T07:25:00.123Z"
            }
            """.data(using: .utf8) else {
                XCTFail("Failed to convert dateTime JSON string to Data")
                return
            }

            // A time interval that consists of a duration and end_date_time
            guard let timeIntervalJson = """
            {
                "time_interval": {
                    "duration": {
                        "value": 10,
                        "unit": "d"
                    },
                    "end_date_time": "2013-02-05T07:35:00Z"
                }
            }
            """.data(using: .utf8) else {
                XCTFail("Failed to convert timeInterval JSON string to Data")
                return
            }

            let decoder = JSONDecoder()

            do {
                let dateTimeTimeFrame = try decoder.decode(TimeFrame.self, from: dateTimeJson)
                XCTAssertNotNil(dateTimeTimeFrame.dateTime)
                XCTAssertNil(dateTimeTimeFrame.timeInterval)
            } catch {
                XCTFail("Failed to decode TimeFrame for dateTime: \(error)")
            }

            do {
                let timeIntervalTimeFrame = try decoder.decode(TimeFrame.self, from: timeIntervalJson)
                XCTAssertNil(timeIntervalTimeFrame.dateTime)
                XCTAssertNotNil(timeIntervalTimeFrame.timeInterval)
            } catch {
                XCTFail("Failed to decode TimeFrame for timeInterval: \(error)")
            }
        }
    
    struct TestUnit: UnitProtocol, Equatable {
        var name: String
    }
    
    func testTypedUnitValueWithDoubleValue() {
        let unit = TestUnit(name: "TestUnit1")
        let value: Double = 10.5

        let typedUnitValue = TypedUnitValue(unit: unit, value: value)

        XCTAssertEqual(typedUnitValue.unit, unit)
        XCTAssertEqual(typedUnitValue.value, value)
    }

    func testTypedUnitValueWithIntValue() {
        let unit = TestUnit(name: "TestUnit2")
        let intValue: Int = 10
        let doubleValue = Double(intValue)

        let typedUnitValue = TypedUnitValue(unit: unit, value: intValue)

        XCTAssertEqual(typedUnitValue.unit, unit)
        XCTAssertEqual(typedUnitValue.value, doubleValue)
    }

    func testTypedUnitValueDecoding() throws {
        let json = """
        {
            "unit": {
                "name": "TestUnit3"
            },
            "value": 15.5
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let typedUnitValue = try decoder.decode(TypedUnitValue<TestUnit>.self, from: json)

        XCTAssertEqual(typedUnitValue.unit.name, "TestUnit3")
        XCTAssertEqual(typedUnitValue.value, 15.5)
    }

    func testTypedUnitValueEncoding() throws {
        let unit = TestUnit(name: "TestUnit4")
        let value: Double = 20.5
        let typedUnitValue = TypedUnitValue(unit: unit, value: value)

        let encoder = JSONEncoder()
        XCTAssertNoThrow(try encoder.encode(typedUnitValue), "Encoding should not throw an error")
    }

    func testEquality() {
        let unit1 = TestUnit(name: "TestUnit5")
        let unit2 = TestUnit(name: "TestUnit6")

        let value1 = TypedUnitValue(unit: unit1, value: 30.0)
        let value2 = TypedUnitValue(unit: unit1, value: 30.0)
        let value3 = TypedUnitValue(unit: unit2, value: 40.0)

        XCTAssertEqual(value1, value2)
        XCTAssertNotEqual(value1, value3)
    }
}
