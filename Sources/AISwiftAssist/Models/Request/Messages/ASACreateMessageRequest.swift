//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents a request to create a message within a thread.
public struct ASACreateMessageRequest: Codable, Sendable {
    /// Role of the entity creating the message (user or assistant).
    public let role: ASAMessage.Role

    /// Content of the message (text, image URLs, or image files).
    public let content: [ASAMessage.Content]

    /// Optional attachments associated with the message.
    public let attachments: [ASAMessage.Attachment]?

    /// Optional metadata (max 16 key-value pairs).
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case role, content, attachments, metadata
    }

    public init(role: ASAMessage.Role,
                content: [ASAMessage.Content],
                attachments: [ASAMessage.Attachment]? = nil,
                metadata: [String: String]? = nil) {
        self.role = role
        self.content = content
        self.attachments = attachments
        self.metadata = metadata
    }
}
