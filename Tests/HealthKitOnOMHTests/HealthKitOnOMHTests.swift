//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import HealthKitOnOMH
import XCTest


final class HealthKitOnOMHTests: XCTestCase {
    func testHealthKitOnOMH() throws {
        let healthKitOnOMH = HealthKitOnOMH()
        XCTAssertEqual(healthKitOnOMH.stanford, "Stanford University")
    }
}
