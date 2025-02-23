//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Testing
import HealthKit
@testable import HealthKitOnOMH

@Suite("HealthKitOnOMH Tests")
struct HealthKitOnOMHTests {
    @Test("Test Heart Rate Conversion")
    func testHeartRate() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let heartRateSample = HKQuantitySample(
            type: HKQuantityType(.heartRate),
            quantity: HKQuantity(unit: .count().unitDivided(by: .minute()), doubleValue: 120),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(heartRateSample.omhDataPoint as? any DataPoint<HeartRate>)
        
        #expect(omhDataPoint.body.heartRate.value == 120)
        #expect(omhDataPoint.body.heartRate.unit == HeartRateUnit.beatsPerMinute)
    }
    
    @Test("Test Blood Glucose Conversion")
    func testBloodGlucose() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let bloodGlucoseSample = HKQuantitySample(
            type: HKQuantityType(.bloodGlucose),
            quantity: HKQuantity(unit: HKUnit(from: "mg/dL"), doubleValue: 90),
            start: startDate,
            end: endDate,
            metadata: [HKMetadataKeyBloodGlucoseMealTime: 1]
        )
        
        let omhDataPoint = try #require(bloodGlucoseSample.omhDataPoint as? any DataPoint<BloodGlucose>)
        
        #expect(omhDataPoint.body.bloodGlucose.value == 90)
        #expect(omhDataPoint.body.bloodGlucose.unit == BloodGlucoseUnit.milligramsPerDeciliter)
    }
    
    @Test("Test Step Count Conversion")
    func testStepCount() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let stepCountSample = HKQuantitySample(
            type: HKQuantityType(.stepCount),
            quantity: HKQuantity(unit: HKUnit(from: "count"), doubleValue: 100),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(stepCountSample.omhDataPoint as? any DataPoint<StepCount>)
        
        #expect(omhDataPoint.body.stepCount.value == 100)
        #expect(omhDataPoint.body.stepCount.unit == .steps)
    }
    
    @Test("Test Body Height Conversion")
    func testBodyHeight() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let bodyHeightSample = HKQuantitySample(
            type: HKQuantityType(.height),
            quantity: HKQuantity(unit: HKUnit(from: "cm"), doubleValue: 180),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(bodyHeightSample.omhDataPoint as? any DataPoint<BodyHeight>)
        
        #expect(omhDataPoint.body.bodyHeight.value == 180)
        #expect(omhDataPoint.body.bodyHeight.unit == LengthUnit.cm)
    }
    
    @Test("Test Body Weight Conversion")
    func testBodyWeight() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let bodyWeightSample = HKQuantitySample(
            type: HKQuantityType(.bodyMass),
            quantity: HKQuantity(unit: HKUnit(from: "kg"), doubleValue: 100),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(bodyWeightSample.omhDataPoint as? any DataPoint<BodyWeight>)
        
        #expect(omhDataPoint.body.bodyWeight.value == 100)
        #expect(omhDataPoint.body.bodyWeight.unit == MassUnit.kg)
    }
    
    @Test("Test Body Temperature Conversion")
    func testBodyTemperature() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let bodyTemperatureSample = HKQuantitySample(
            type: HKQuantityType(.bodyTemperature),
            quantity: HKQuantity(unit: .degreeCelsius(), doubleValue: 37),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(bodyTemperatureSample.omhDataPoint as? any DataPoint<BodyTemperature>)
        
        #expect(omhDataPoint.body.bodyTemperature.value == 37)
        #expect(omhDataPoint.body.bodyTemperature.unit == TemperatureUnit.C)
    }
    
    @Test("Test Respiratory Rate Conversion")
    func testRespiratoryRate() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let respiratoryRateSample = HKQuantitySample(
            type: HKQuantityType(.respiratoryRate),
            quantity: HKQuantity(unit: HKUnit.count().unitDivided(by: .minute()), doubleValue: 20),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(respiratoryRateSample.omhDataPoint as? any DataPoint<RespiratoryRate>)
        
        #expect(omhDataPoint.body.respiratoryRate.value == 20)
        #expect(omhDataPoint.body.respiratoryRate.unit == RespiratoryRateUnit.breathsPerMinute)
    }
    
    @Test("Test Oxygen Saturation Conversion")
    func testOxygenSaturation() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let oxygenSaturationSample = HKQuantitySample(
            type: HKQuantityType(.oxygenSaturation),
            quantity: HKQuantity(unit: HKUnit.percent(), doubleValue: 99),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(oxygenSaturationSample.omhDataPoint as? any DataPoint<OxygenSaturation>)
        
        #expect(omhDataPoint.body.oxygenSaturation.value == 99)
        #expect(omhDataPoint.body.oxygenSaturation.unit == OxygenSaturationUnit.percent)
    }
    
    @Test("Test Body Fat Percentage Conversion")
    func testBodyFatPercentage() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let bodyFatPercentageSample = HKQuantitySample(
            type: HKQuantityType(.bodyFatPercentage),
            quantity: HKQuantity(unit: HKUnit.percent(), doubleValue: 16),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(bodyFatPercentageSample.omhDataPoint as? any DataPoint<BodyFatPercentage>)
        
        #expect(omhDataPoint.body.bodyFatPercentage.value == 16)
        #expect(omhDataPoint.body.bodyFatPercentage.unit == BodyFatPercentageUnit.percent)
    }
    
    @Test("Test Body Mass Index Conversion")
    func testBodyMassIndex() throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let bodyMassIndexSample = HKQuantitySample(
            type: HKQuantityType(.bodyMassIndex),
            quantity: HKQuantity(unit: HKUnit.count(), doubleValue: 22.5),
            start: startDate,
            end: endDate
        )
        
        let omhDataPoint = try #require(bodyMassIndexSample.omhDataPoint as? any DataPoint<BodyMassIndex>)
        
        #expect(omhDataPoint.body.bodyMassIndex.value == 22.5)
        #expect(omhDataPoint.body.bodyMassIndex.unit == BodyMassIndexUnit.kilogramsPerMeterSquared)
    }
    
    @Test("Test Unsupported Quantity Type")
    func testUnsupportedQuantityType() async throws {
        let startDate = try makeStartDate()
        let endDate = try makeEndDate()
        
        let sample = HKQuantitySample(
            type: HKQuantityType(.nikeFuel),
            quantity: HKQuantity(unit: .count(), doubleValue: 1),
            start: startDate,
            end: endDate
        )
        
        await #expect(throws: HealthKitOnOMHError.notSupported) {
            try await _ = sample.omhDataPoint
        }
    }
    
    @Test("Test JSON Encoding")
    func testEncoding() throws {
        let date = ISO8601DateFormatter().date(from: "1885-11-11T00:00:00-08:00") ?? .now
        let sample = HKQuantitySample(
            type: HKQuantityType(.heartRate),
            quantity: HKQuantity(unit: HKUnit.count().unitDivided(by: .minute()), doubleValue: 42.0),
            start: date,
            end: date
        )
        
        let omhDataPoint = try #require(sample.omhDataPoint as? any DataPoint<HeartRate>)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        _ = try encoder.encode(omhDataPoint)
    }
    
    // Helper functions for date creation
    private func makeStartDate() throws -> Date {
        let dateComponents = DateComponents(
            year: 1891,
            month: 10,
            day: 1,
            hour: 12,
            minute: 0,
            second: 0
        )
        return try #require(Calendar.current.date(from: dateComponents))
    }
    
    private func makeEndDate() throws -> Date {
        let dateComponents = DateComponents(
            year: 1891,
            month: 10,
            day: 1,
            hour: 12,
            minute: 0,
            second: 42
        )
        return try #require(Calendar.current.date(from: dateComponents))
    }
}
