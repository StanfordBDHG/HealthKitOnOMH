//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit
@testable import HealthKitOnOMH
import XCTest


final class HealthKitOnOMHTests: XCTestCase {
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
    
    func testHeartRate() throws {
        let heartRateSample = HKQuantitySample(
            type: HKQuantityType(.heartRate),
            quantity: HKQuantity(unit: .count().unitDivided(by: .minute()), doubleValue: 120),
            start: try startDate,
            end: try endDate
        )
        
        let omhDataPoint = try XCTUnwrap(heartRateSample.dataPoint as? any DataPoint<HeartRate>)
        
        XCTAssertEqual(120, omhDataPoint.body.heartRate.value)
        XCTAssertEqual(HeartRateUnit.beatsPerMinute, omhDataPoint.body.heartRate.unit)
    }
    
    func testBloodGlucose() throws {
        let bloodGlucoseSample = HKQuantitySample(
            type: HKQuantityType(.bloodGlucose),
            quantity: HKQuantity(unit: HKUnit(from: "mg/dL"), doubleValue: 90),
            start: try startDate,
            end: try endDate,
            metadata: [HKMetadataKeyBloodGlucoseMealTime: 1]
        )
        
        let omhDataPoint = try XCTUnwrap(bloodGlucoseSample.dataPoint as? any DataPoint<BloodGlucose>)
        
        XCTAssertEqual(90, omhDataPoint.body.bloodGlucose.value)
        XCTAssertEqual(BloodGlucoseUnit.milligramsPerDeciliter, omhDataPoint.body.bloodGlucose.unit)
    }
    
    func testStepCount() throws {
        let stepCountSample = HKQuantitySample(
            type: HKQuantityType(.stepCount),
            quantity: HKQuantity(unit: HKUnit(from: "count"), doubleValue: 100),
            start: try startDate,
            end: try endDate
        )
        
        let omhDataPoint = try XCTUnwrap(stepCountSample.dataPoint as? any DataPoint<StepCount>)
        
        XCTAssertEqual(100, omhDataPoint.body.stepCount.value)
        XCTAssertEqual(.steps, omhDataPoint.body.stepCount.unit)
    }

    func testBodyHeight() throws {
        let bodyHeightSample = HKQuantitySample(
            type: HKQuantityType(.height),
            quantity: HKQuantity(unit: HKUnit(from: "cm"), doubleValue: 180),
            start: try startDate,
            end: try endDate
        )

        let omhDataPoint = try XCTUnwrap(bodyHeightSample.dataPoint as? any DataPoint<BodyHeight>)

        XCTAssertEqual(180, omhDataPoint.body.bodyHeight.value)
        XCTAssertEqual(LengthUnit.cm, omhDataPoint.body.bodyHeight.unit)
    }

    func testBodyWeight() throws {
        let bodyWeightSample = HKQuantitySample(
            type: HKQuantityType(.bodyMass),
            quantity: HKQuantity(unit: HKUnit(from: "kg"), doubleValue: 100),
            start: try startDate,
            end: try endDate
        )

        let omhDataPoint = try XCTUnwrap(bodyWeightSample.dataPoint as? any DataPoint<BodyWeight>)

        XCTAssertEqual(100, omhDataPoint.body.bodyWeight.value)
        XCTAssertEqual(MassUnit.kg, omhDataPoint.body.bodyWeight.unit)
    }
    
    func testBodyTemperature() throws {
        let bodyTemperatureSample = HKQuantitySample(
            type: HKQuantityType(.bodyTemperature),
            quantity: HKQuantity(unit: .degreeCelsius(), doubleValue: 37),
            start: try startDate,
            end: try endDate
        )
        
        let omhDataPoint = try XCTUnwrap(bodyTemperatureSample.dataPoint as? any DataPoint<BodyTemperature>)
        
        XCTAssertEqual(37, omhDataPoint.body.bodyTemperature.value)
        XCTAssertEqual(TemperatureUnit.C, omhDataPoint.body.bodyTemperature.unit)
    }
}
