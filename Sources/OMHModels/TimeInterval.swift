//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


/// This schema describes an interval of time. In the absence of a precise start and/or end time, the time interval can be described as a date + a part of the day (morning, afternoon, evening, night). No commitments are made as to whether the start or end time point itself is included in the interval (i.e., whether the defined interval includes the boundary point(s) or not).
/// Generated from Open mHealth `omh:time-interval:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_time-interval)
public struct TimeInterval: Codable, Equatable {
    public var startDateTime: Date?
    public var endDateTime: Date?
    public var duration: DurationUnitValue?
    public var date: Date?
    public var partOfDay: PartOfDay?

    public init(startDateTime: Date, duration: DurationUnitValue) {
        self.startDateTime = startDateTime
        self.duration = duration
    }

    public init(endDateTime: Date, duration: DurationUnitValue) {
        self.endDateTime = endDateTime
        self.duration = duration
    }

    public init(startDateTime: Date, endDateTime: Date) {
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
    }

    public init(date: Date, partOfDay: PartOfDay) {
        self.date = date
        self.partOfDay = partOfDay
    }

    public static func == (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        lhs.startDateTime == rhs.startDateTime &&
        lhs.endDateTime == rhs.endDateTime &&
        lhs.duration == rhs.duration &&
        lhs.date == rhs.date &&
        lhs.partOfDay == rhs.partOfDay
    }
}
