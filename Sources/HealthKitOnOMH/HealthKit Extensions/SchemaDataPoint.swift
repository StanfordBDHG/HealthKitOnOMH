//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


struct SchemaDataPoint<T: Schema & Sendable>: DataPoint {
    var header: Header
    var body: T
}
