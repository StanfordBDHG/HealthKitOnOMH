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
    
    func testBloodGlucose() throws {
        let beforeBreakfastGlucose = BloodGlucose(
            bloodGlucose: UnitValue(unit: "mg/dL", value: 80),
            effectiveTimeFrame: TimeInterval(startDateTime: try startDate, endDateTime: try endDate),
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToMeal: TemporalRelationshipToMeal.beforeBreakfast
        )
        
        XCTAssertEqual(80, beforeBreakfastGlucose.bloodGlucose.value)
        XCTAssertEqual(beforeBreakfastGlucose.temporalRelationshipToMeal, TemporalRelationshipToMeal.beforeBreakfast)
        XCTAssertEqual(beforeBreakfastGlucose.specimenSource, SpecimenSource.capillaryBlood)
        
        let duringSleepBloodGlucose = BloodGlucose(
            bloodGlucose: UnitValue(unit: "mg/dL", value: 70),
            effectiveTimeFrame: TimeInterval(startDateTime: try startDate, endDateTime: try endDate),
            specimenSource: SpecimenSource.capillaryBlood,
            temporalRelationshipToSleep: TemporalRelationshipToSleep.duringSleep
        )
        
        XCTAssertEqual(duringSleepBloodGlucose.temporalRelationshipToSleep, TemporalRelationshipToSleep.duringSleep)
        
        let averageBloodGlucose = BloodGlucose(
            bloodGlucose: UnitValue(unit: "mg/dL", value: 120),
            effectiveTimeFrame: TimeInterval(startDateTime: try startDate, endDateTime: try endDate),
            descriptiveStatistic: DescriptiveStatistic.average
        )
        
        XCTAssertEqual(averageBloodGlucose.descriptiveStatistic, DescriptiveStatistic.average)
    }
}
