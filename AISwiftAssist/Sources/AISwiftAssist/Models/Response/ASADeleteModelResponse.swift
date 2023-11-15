//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public struct ASADeleteModelResponse: Codable {
    /// The model identifier, which can be referenced in the API endpoints.
    public let id: String

    /// The object type, which is always "model".
    public let object: String

    /// The deletion status of the model.
    public let deleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, object, deleted
    }
}
