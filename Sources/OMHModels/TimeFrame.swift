//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation

/// Enables a particular time frame to be described as either a point in time or a time interval.
/// Generated from Open mHealth `omh:time-frame:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_time-frame)
public struct TimeFrame: Codable, Equatable {
    public let dateTime: DateTime?
    public let timeInterval: TimeInterval?

    enum CodingKeys: String, CodingKey {
        case dateTime = "date_time"
        case timeInterval = "time_interval"
    }

    public init(dateTime: DateTime) {
        self.dateTime = dateTime
        self.timeInterval = nil
    }

    public init(timeInterval: TimeInterval) {
        self.dateTime = nil
        self.timeInterval = timeInterval
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try container.decodeIfPresent(DateTime.self, forKey: .dateTime)
        timeInterval = try container.decodeIfPresent(TimeInterval.self, forKey: .timeInterval)
        guard dateTime != nil || timeInterval != nil else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath, debugDescription: "Invalid time frame data")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let dateTime = dateTime {
            try container.encode(dateTime, forKey: .dateTime)
        } else if let timeInterval = timeInterval {
            try container.encode(timeInterval, forKey: .timeInterval)
        }
    }

    public static func == (lhs: TimeFrame, rhs: TimeFrame) -> Bool {
        return lhs.dateTime == rhs.dateTime && lhs.timeInterval == rhs.timeInterval
    }
}
