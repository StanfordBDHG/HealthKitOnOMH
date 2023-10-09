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

            let timeFrame = TimeFrame(
                timeInterval: TimeInterval(
                    startDateTime: self.startDate,
                    endDateTime: self.endDate
                )
            )

            switch sampleType {
            case HKQuantityType(.bloodGlucose):
                schema = BloodGlucose(
                    bloodGlucose: BloodGlucoseUnitValue(
                        unit: .milligramsPerDeciliter,
                        value: self.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                    ),
                    effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.heartRate):
                schema = HeartRate(
                    heartRate: HeartRateUnitValue(
                        unit: .beatsPerMinute,
                        value: self.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    ),
                    effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.stepCount):
                schema = StepCount(
                    stepCount: StepCountUnitValue(
                        unit: .steps,
                        value: self.quantity.doubleValue(for: HKUnit(from: "count"))
                    ),
                    effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.bodyMass):
                schema = BodyWeight(
                    bodyWeight: MassUnitValue(
                        unit: .kg,
                        value: self.quantity.doubleValue(for: HKUnit(from: "kg"))
                    ), effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.height):
                schema = BodyHeight(
                    bodyHeight: LengthUnitValue(
                        unit: .cm,
                        value: self.quantity.doubleValue(for: HKUnit(from: "cm"))
                    ),
                    effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.bodyTemperature):
                schema = BodyTemperature(
                    bodyTemperature: TemperatureUnitValue(
                        unit: .C,
                        value: self.quantity.doubleValue(for: .degreeCelsius())
                    ),
                    effectiveTimeFrame: timeFrame
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
        case HKQuantityType(.bodyTemperature):
            unit = "degC"
        case HKQuantityType(.oxygenSaturation):
            unit = "%"
        case HKQuantityType(.respiratoryRate):
            unit = "count/min"
        default:
            throw HealthKitOnOMHError.notSupported
        }

        let value = self.quantity.doubleValue(for: HKUnit(from: unit))

        let timeFrame = TimeFrame(
            timeInterval: TimeInterval(
                startDateTime: self.startDate,
                endDateTime: self.endDate
            )
        )

        let sample = HealthKitQuantitySample<Double>(
            quantityType: self.quantityType.identifier,
            unitValue: UnitValue<Double>(unit: unit, value: value),
            effectiveTimeFrame: timeFrame
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
