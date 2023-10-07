//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation

/// This schema describes an interval of time.
/// Generated from Open mHealth `omh:time-interval:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_time-interval)
public struct TimeInterval: Codable, Equatable, Comparable {
    /// The start timestamp of this interval
    public var startDateTime: Date

    /// The end timestamp of this interval
    public var endDateTime: Date
    
    
    public init (
        startDateTime: Date,
        endDateTime: Date
    ) {
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
    }
    
    public static func ==(lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        return lhs.startDateTime == rhs.startDateTime && lhs.endDateTime == rhs.endDateTime
    }
    
    public static func <(lhs: TimeInterval, rhs: TimeInterval) -> Bool {
        if lhs.startDateTime == rhs.startDateTime {
            return lhs.endDateTime < rhs.endDateTime
        }
        return lhs.startDateTime < rhs.startDateTime
    }
}
