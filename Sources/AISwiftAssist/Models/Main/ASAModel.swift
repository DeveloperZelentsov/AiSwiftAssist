//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public struct ASAModel: Codable {
    // The model identifier, which can be referenced in the API endpoints.
    public let id: String

    // The Unix timestamp (in seconds) when the model was created.
    public let created: Int

    // The object type, which is always "model".
    public let object: String

    // The organization that owns the model.
    public let ownedBy: String

    enum CodingKeys: String, CodingKey {
        case id, created, object
        case ownedBy = "owned_by"
    }
}
