//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation

open class TimeInterval: Codable {
    public var startDateTime: Date
    public var endDateTime: Date

    public init (
        startDateTime: Date,
        endDateTime: Date
    ) {
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
    }
}
