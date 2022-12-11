//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit
import OMHModels


extension HKQuantitySample {
    func buildBloodGlucoseDataPoint() throws -> DataPoint<BloodGlucose> {
        let body = BloodGlucose(
            bloodGlucose: UnitValue<Double>(
                unit: "mg/dL",
                value: self.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
            ),
            effectiveTimeFrame: TimeInterval(
                startDateTime: self.startDate,
                endDateTime: self.endDate
            )
        )

        let header = Header(
            id: self.uuid.uuidString,
            creationDateTime: Date(),
            schemaId: body.schemaId
        )

        return DataPoint<BloodGlucose>(
            header: header,
            body: body
        )
    }

    func buildHKQuantityDataPoint() throws -> DataPoint<HealthKitQuantitySample<Double>> {
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

        let body = HealthKitQuantitySample<Double>(
            quantityType: self.quantityType.identifier,
            unitValue: UnitValue<Double>(unit: unit, value: value),
            effectiveTimeFrame: TimeInterval(
                startDateTime: self.startDate,
                endDateTime: self.endDate
            )
        )

        let header = Header(
            id: self.uuid.uuidString,
            creationDateTime: Date(),
            schemaId: body.schemaId
        )

        return DataPoint<HealthKitQuantitySample>(
            header: header,
            body: body
        )
    }
}
