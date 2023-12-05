//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents a file attached to a message.
public struct ASAMessageFile: Codable {
    /// The identifier of the file, which can be referenced in API endpoints.
    public let id: String

    /// The object type, which is always 'thread.message.file'.
    public let object: String

    /// The Unix timestamp (in seconds) for when the message file was created.
    public let createdAt: Int

    /// The ID of the message that the file is attached to.
    public let messageId: String

    enum CodingKeys: String, CodingKey {
        case id, object
        case createdAt = "created_at"
        case messageId = "message_id"
    }
}
