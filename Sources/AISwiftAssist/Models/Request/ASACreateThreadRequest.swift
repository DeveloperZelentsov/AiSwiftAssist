//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// A request structure for creating a thread.
public struct ASACreateThreadRequest: Codable, Sendable {
    /// Optional: A list of messages to start the thread with.
    public let messages: [Message]?

    /// Optional: Resources available to the assistant's tools in this thread.
    public let toolResources: ASAThread.ToolResources?

    /// Optional: A helper to create a vector store and attach it to this thread (max 1).
    public let vectorStores: [VectorStore]?

    /// Optional: Metadata associated with the thread (max 16 key-value pairs).
    public let metadata: [String: String]?

    public struct Message: Codable, Sendable {
        /// Required: The role of the entity that is creating the message ('user' or 'assistant').
        public let role: String

        /// Required: The content of the message (can be string or array, simplified to string here).
        public let content: String

        /// Optional: A list of file attachments.
        public let attachments: [Attachment]?

        /// Optional: Metadata for the message (max 16 key-value pairs).
        public let metadata: [String: String]?

        enum CodingKeys: String, CodingKey {
            case role, content, attachments, metadata
        }
    }

    public struct Attachment: Codable, Sendable {
        /// The ID of the file to attach.
        public let fileId: String

        /// Tools to add the file to.
        public let tools: [Tool]?

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
            case tools
        }
    }

    public struct Tool: Codable, Sendable {
        /// Type of tool (e.g., 'file_search').
        public let type: String

        enum CodingKeys: String, CodingKey {
            case type
        }
    }

    public struct VectorStore: Codable, Sendable {
        /// A list of file IDs to add to the vector store (max 10000 files).
        public let fileIds: [String]?

        /// Optional metadata for the vector store (max 16 key-value pairs).
        public let metadata: [String: String]?

        enum CodingKeys: String, CodingKey {
            case fileIds = "file_ids"
            case metadata
        }
    }

    enum CodingKeys: String, CodingKey {
        case messages
        case toolResources = "tool_resources"
        case vectorStores = "vector_stores"
        case metadata
    }

    public init(
        messages: [Message]? = nil,
        toolResources: ASAThread.ToolResources? = nil,
        vectorStores: [VectorStore]? = nil,
        metadata: [String: String]? = nil
    ) {
        self.messages = messages
        self.toolResources = toolResources
        self.vectorStores = vectorStores
        self.metadata = metadata
    }
}
