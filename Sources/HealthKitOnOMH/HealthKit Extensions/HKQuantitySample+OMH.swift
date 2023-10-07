//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit
@_exported import OMHModels


extension HKQuantitySample {
    /// The OMH data point created from converting this HKQuantitySample
    public var dataPoint: any DataPoint {
        get throws {
            let schema: any Schema
            switch sampleType {
            case HKQuantityType(.bloodGlucose):
                schema = BloodGlucose(
                    bloodGlucose: UnitValue<Double>(
                        unit: "mg/dL",
                        value: self.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                    ),
                    effectiveTimeFrame: TimeInterval(
                        startDateTime: self.startDate,
                        endDateTime: self.endDate
                    )
                )
            case HKQuantityType(.heartRate):
                schema = HeartRate(
                    heartRate: UnitValue<Double>(
                        unit: "beats/min",
                        value: self.quantity.doubleValue(for: HKUnit(from: "bpm"))
                    ),
                    effectiveTimeFrame: TimeInterval(
                        startDateTime: self.startDate,
                        endDateTime: self.endDate
                    )
                )
            case HKQuantityType(.stepCount):
                schema = StepCount(
                    stepCount: UnitValue<Double>(
                        unit: "steps",
                        value: self.quantity.doubleValue(for: HKUnit(from: "steps"))
                    ),
                    effectiveTimeFrame: TimeInterval(
                        startDateTime: self.startDate,
                        endDateTime: self.endDate
                    )
                )
            default:
                return try buildHKQuantityDataPoint()
            }
            
            return createTypedDataPoint(schema)
        }
    }
    
    
    private func buildHKQuantityDataPoint() throws -> any DataPoint {
        var unit = ""
        switch self.quantityType {
        case HKQuantityType(.heartRate):
            unit = "count/min"
        case HKQuantityType(.bodyMass):
            unit = "kg"
        case HKQuantityType(.bodyTemperature):
            unit = "degC"
        case HKQuantityType(.height):
            unit = "m"
        case HKQuantityType(.oxygenSaturation):
            unit = "%"
        case HKQuantityType(.respiratoryRate):
            unit = "count/min"
        case HKQuantityType(.stepCount):
            unit = "count"
        default:
            throw HealthKitOnOMHError.notSupported
        }

        let value = self.quantity.doubleValue(for: HKUnit(from: unit))
        
        let sample = HealthKitQuantitySample<Double>(
            quantityType: self.quantityType.identifier,
            unitValue: UnitValue<Double>(unit: unit, value: value),
            effectiveTimeFrame: TimeInterval(
                startDateTime: self.startDate,
                endDateTime: self.endDate
            )
        )

        return createTypedDataPoint(sample)
    }
    
    private func createTypedDataPoint<T: Schema>(_ body: T) -> any DataPoint {
        SchemaDataPoint<T>(
            header: Header(
                id: self.uuid.uuidString,
                creationDateTime: Date(),
                schemaId: type(of: body).schemaId
            ),
            body: body
        )
    }
}
