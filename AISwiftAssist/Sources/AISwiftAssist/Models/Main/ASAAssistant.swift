//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents an assistant that can call the model and use tools.
public struct ASAAssistant: Codable {
    /// The identifier of the assistant, which can be referenced in API endpoints.
    public let id: String

    /// The object type, which is always 'assistant'.
    public let objectType: String

    /// The Unix timestamp (in seconds) for when the assistant was created.
    public let createdAt: Int

    /// Optional: The name of the assistant. The maximum length is 256 characters.
    public let name: String?

    /// Optional: The description of the assistant. The maximum length is 512 characters.
    public let description: String?

    /// ID of the model to use. You can use the List models API to see all of your available models.
    public let model: String

    /// Optional: The system instructions that the assistant uses. The maximum length is 32768 characters.
    public let instructions: String?

    /// A list of tools enabled on the assistant. There can be a maximum of 128 tools per assistant.
    /// Tools can be of types code_interpreter, retrieval, or function.
    public let tools: [Tool]

    /// A list of file IDs attached to this assistant. There can be a maximum of 20 files attached to the assistant.
    /// Files are ordered by their creation date in ascending order.
    public let fileIds: [String]

    /// Optional: Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information
    /// about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.
    public let metadata: [String: String]?

    public enum CodingKeys: String, CodingKey {
        case id
        case objectType = "object"
        case createdAt = "created_at"
        case name, description, model, instructions, tools
        case fileIds = "file_ids"
        case metadata
    }

    /// Represents a tool enabled on the assistant.
    public struct Tool: Codable {
        /// The type of the tool (e.g., code_interpreter, retrieval, function).
        public let type: String
    }
}

