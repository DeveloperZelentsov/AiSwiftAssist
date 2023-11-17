//
//  File.swift
//  
//
//  Created by Alexey on 11/16/23.
//

import Foundation

/// Represents a response containing a list of messages.
public struct ASAMessagesListResponse: Codable {
    /// The object type, which is always 'list'.
    public let object: String

    /// The list of messages.
    public let data: [ASAMessage]

    /// The ID of the first message in the list.
    public let firstId: String

    /// The ID of the last message in the list.
    public let lastId: String

    /// Indicates whether there are more messages to fetch.
    public let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case object, data
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }
}
