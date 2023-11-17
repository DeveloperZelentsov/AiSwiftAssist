//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// A request structure for creating a thread.
public struct ASACreateThreadRequest: Codable {
    /// Optional: A list of messages to start the thread with.
    public let messages: [Message]?

    public struct Message: Codable {
        /// Required: The role of the entity that is creating the message. Currently, only 'user' is supported.
        public let role: String

        /// Required: The content of the message.
        public let content: String

        /// Optional: A list of File IDs that the message should use. A maximum of 10 files can be attached to a message.
        public let fileIds: [String]?

        /// Optional: Set of 16 key-value pairs that can be attached to the message. Useful for storing additional information.
        public let metadata: [String: String]?

        enum CodingKeys: String, CodingKey {
            case role, content
            case fileIds = "file_ids"
            case metadata
        }
    }

    public init(messages: [Message]? = nil) {
        self.messages = messages
    }
}
