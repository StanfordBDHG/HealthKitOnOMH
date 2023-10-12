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
    public var omhDataPoint: any DataPoint {
        get throws {
            let schema: any Schema

            let timeFrame = TimeFrame(
                timeInterval: TimeInterval(
                    startDateTime: DateTime(date: self.startDate),
                    endDateTime: DateTime(date: self.endDate)
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
            case HKQuantityType(.bodyFatPercentage):
                schema = BodyFatPercentage(
                    bodyFatPercentage: BodyFatPercentageUnitValue(
                        unit: .percent,
                        value: self.quantity.doubleValue(for: HKUnit(from: "%"))
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
            case HKQuantityType(.bodyTemperature):
                schema = BodyTemperature(
                    bodyTemperature: TemperatureUnitValue(
                        unit: .C,
                        value: self.quantity.doubleValue(for: HKUnit(from: "degC"))
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
            case HKQuantityType(.height):
                schema = BodyHeight(
                    bodyHeight: LengthUnitValue(
                        unit: .cm,
                        value: self.quantity.doubleValue(for: HKUnit(from: "cm"))
                    ),
                    effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.oxygenSaturation):
                schema = OxygenSaturation(
                    oxygenSaturation: OxygenSaturationUnitValue(
                        unit: .percent,
                        value: self.quantity.doubleValue(for: HKUnit(from: "%"))
                    ),
                    effectiveTimeFrame: timeFrame
                )
            case HKQuantityType(.respiratoryRate):
                schema = RespiratoryRate(
                    respiratoryRate: RespiratoryRateUnitValue(
                        unit: .breathsPerMinute,
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
            default:
                throw HealthKitOnOMHError.notSupported
            }
            
            return createTypedDataPoint(schema)
        }
    }
    
    private func createTypedDataPoint<T: Schema>(_ body: T) -> any DataPoint {
        SchemaDataPoint<T>(
            header: Header(
                id: self.uuid.uuidString,
                creationDateTime: DateTime(date: Date()),
                schemaId: type(of: body).schemaId
            ),
            body: body
        )
    }
}
