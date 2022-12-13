//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT


public struct SchemaId: Sendable, Codable, CustomStringConvertible {
    public var namespace: SchemaNamespace
    public var name: String
    public var version: String
    
    
    public var description: String {
        "\(namespace.rawValue):\(name):\(version))"
    }
    
    
    public init (
        namespace: SchemaNamespace,
        name: String,
        version: String
    ) {
        self.namespace = namespace
        self.name = name
        self.version = version
    }
}
