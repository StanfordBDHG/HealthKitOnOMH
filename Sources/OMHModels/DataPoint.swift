//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


/// A protocol for an Open mHealth data point container
/// Generated from Open mHealth `omh:data-point:1.0` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_data-point)
public protocol DataPoint<Body>: Sendable {
    associatedtype Body: Schema
    
    
    var header: Header { get }
    var body: Body { get set }
}
