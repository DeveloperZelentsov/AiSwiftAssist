//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// A response structure for listing assistants.
public struct ASAAssistantsListResponse: Codable {
    /// The object type, which is always 'list'.
    public let object: String

    /// The list of assistant objects.
    public let data: [ASAAssistant]

    /// The ID of the first assistant in the list.
    public let firstId: String

    /// The ID of the last assistant in the list.
    public let lastId: String

    /// Boolean indicating whether there are more objects after the last one in the list.
    public let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case object, data
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }
}
