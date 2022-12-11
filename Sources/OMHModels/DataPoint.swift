//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


open class DataPoint<T: OMHSchema>: Codable {
    public var header: Header
    public var body: T
}
