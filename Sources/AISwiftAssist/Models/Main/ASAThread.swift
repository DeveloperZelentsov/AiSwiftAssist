//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents a thread that contains messages.
public struct ASAThread: Codable, Sendable {
    /// The identifier of the thread, which can be referenced in API endpoints.
    public let id: String

    /// The object type, always 'thread'.
    public let object: String

    /// The Unix timestamp (in seconds) when the thread was created.
    public let createdAt: Int

    /// Resources available to the assistant's tools in this thread.
    public let toolResources: ToolResources?

    /// Optional metadata (max 16 key-value pairs).
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, object
        case createdAt = "created_at"
        case toolResources = "tool_resources"
        case metadata
    }

    public struct ToolResources: Codable, Sendable {
        public let codeInterpreter: CodeInterpreter?
        public let fileSearch: FileSearch?

        enum CodingKeys: String, CodingKey {
            case codeInterpreter = "code_interpreter"
            case fileSearch = "file_search"
        }
    }

    public struct CodeInterpreter: Codable, Sendable {
        /// A list of file IDs (max 20 files).
        public let fileIds: [String]

        enum CodingKeys: String, CodingKey {
            case fileIds = "file_ids"
        }
    }

    public struct FileSearch: Codable, Sendable {
        /// A list of vector store IDs (max 1).
        public let vectorStoreIds: [String]

        enum CodingKeys: String, CodingKey {
            case vectorStoreIds = "vector_store_ids"
        }
    }

}
