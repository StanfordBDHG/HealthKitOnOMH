//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


public protocol DataPoint<Body>: Sendable {
    associatedtype Body: Schema
    
    
    var header: Header { get }
    var body: Body { get set }
}
