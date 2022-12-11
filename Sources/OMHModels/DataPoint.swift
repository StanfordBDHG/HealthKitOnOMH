//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


open class DataPoint<T: Schema> {
    public var header: Header
    public var body: T

    public init (
        header: Header,
        body: T
    ) {
        self.header = header
        self.body = body
    }
}
