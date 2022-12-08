//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit


extension HKCategorySample {
    func buildOMH() throws -> HkCategorySample {
        let categoryType = self.categoryType.identifier
        let categoryValue = ""
        let timeInterval = TimeInterval(startDateTime: self.startDate, endDateTime: self.endDate)

        return HkCategorySample(
            categoryType: categoryType,
            categoryValue: categoryValue,
            effectiveTimeFrame: timeInterval
        )
    }
}
