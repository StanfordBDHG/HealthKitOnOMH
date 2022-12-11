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

        let omh = try heartRateSample.buildOMHDataPoint()

        XCTAssertEqual(120, omh.unitValue.value)
        XCTAssertEqual("count/min", omh.unitValue.unit)
    }

    func testBloodGlucose() throws {
        let bloodGlucoseSample = HKQuantitySample(
            type: HKQuantityType(.bloodGlucose),
            quantity: HKQuantity(unit: HKUnit(from: "mg/dL"), doubleValue: 90),
            start: try startDate,
            end: try endDate,
            metadata: [HKMetadataKeyBloodGlucoseMealTime: 1]
        )

        let omh = try bloodGlucoseSample.buildOMHDataPoint()

        XCTAssertEqual(90, omh.unitValue.value)
        XCTAssertEqual("mg/dL", omh.unitValue.unit)
    }
}
