//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public struct ASACreateAssistantRequest: Codable {
    /// ID of the model to use. You can use the List models API to see all of your available models.
    public let model: String

    /// Optional: The name of the assistant. The maximum length is 256 characters.
    public let name: String?

    /// Optional: The description of the assistant. The maximum length is 512 characters.
    public let description: String?

    /// Optional: The system instructions that the assistant uses. The maximum length is 32768 characters.
    public let instructions: String?

    /// Optional: A list of tool enabled on the assistant. There can be a maximum of 128 tools per assistant.
    /// Tools can be of types code_interpreter, retrieval, or function.
    public let tools: [Tool]?

    /// Optional: A list of file IDs attached to this assistant. There can be a maximum of 20 files attached to the assistant.
    /// Files are ordered by their creation date in ascending order.
    public let fileIds: [String]?

    /// Optional: Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information
    /// about the object in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.
    public let metadata: [String: String]?

    public enum CodingKeys: String, CodingKey {
        case model, name, description, instructions, tools
        case fileIds = "file_ids"
        case metadata
    }

    public init(model: String, name: String? = nil, description: String? = nil, instructions: String? = nil, tools: [Tool]? = nil, fileIds: [String]? = nil, metadata: [String : String]? = nil) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
    }

    public init(asaModel: ASAModel, name: String? = nil, description: String? = nil, instructions: String? = nil, tools: [Tool]? = nil, fileIds: [String]? = nil, metadata: [String : String]? = nil) {
        self.model = asaModel.id
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
    }

    /// Represents a tool enabled on the assistant.
    public struct Tool: Codable {
        /// The type of the tool (e.g., code_interpreter, retrieval, function).
        let type: String
    }
}
