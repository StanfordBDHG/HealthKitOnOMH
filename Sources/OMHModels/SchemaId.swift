//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
import Foundation


/// A schema identifier for an Open mHealth schema
/// Generated from Open mHealth `omh:schema-id:1.1` (https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_schema-id)
public struct SchemaId: Sendable, Codable, CustomStringConvertible {
    /// The namespace of the schema. A namespace serves to disambiguate schemas with conflicting names.
    public var namespace: SchemaNamespace

    /// The name of the schema.
    public var name: String

    /// The version of the schema.
    public var version: String

    /// A URL to retrieve the schema. If a URL is not specified, it is assumed that the schema can be located using other means.
    public var url: URL?
    
    
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
