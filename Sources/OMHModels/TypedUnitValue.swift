//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

import Foundation


public struct TypedUnitValue<T: UnitProtocol>: Codable {
    public var unit: T
    public var value: Double
    
    private enum CodingKeys: String, CodingKey {
        case unit, value
    }
    
    public init(unit: T, value: Double) {
        self.unit = unit
        self.value = value
    }
    
    public init(unit: T, value: Int) {
        self.unit = unit
        self.value = Double(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unit, forKey: .unit)
        try container.encode(value, forKey: .value)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        unit = try container.decode(T.self, forKey: .unit)
        value = try container.decode(Double.self, forKey: .value)
    }
}

public protocol UnitProtocol: Codable {}
