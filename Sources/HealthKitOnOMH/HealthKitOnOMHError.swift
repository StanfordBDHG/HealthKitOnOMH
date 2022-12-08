//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

/// Error thrown by the HealthKitOnOMH module if transforming a specific `HKSample` type to an OMH schema was not possible.
enum HealthKitOnOMHError: Error {
    /// Indicates that a specific `HKSample` type is currently not supported by HealthKitOnOMH.
    case notSupported
}
