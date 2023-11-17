//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation
/// A request structure for modifying an existing assistant.
public struct ASAModifyAssistantRequest: Codable {

    /// Optional: ID of the model to use.
    public let model: String?

    /// Optional: The name of the assistant. Maximum length is 256 characters.
    public let name: String?

    /// Optional: The description of the assistant. Maximum length is 512 characters.
    public let description: String?

    /// Optional: The system instructions that the assistant uses. Maximum length is 32768 characters.
    public let instructions: String?

    /// Optional: A list of tools enabled on the assistant. Maximum of 128 tools per assistant.
    public let tools: [ASAAssistant.Tool]?

    /// Optional: A list of file IDs attached to the assistant. Maximum of 20 files attached to the assistant.
    public let fileIds: [String]?

    /// Optional: A map of key-value pairs for storing additional information. Maximum of 16 pairs.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case model, name, description, instructions, tools
        case fileIds = "file_ids"
        case metadata
    }

    public init(model: String? = nil, name: String? = nil, description: String? = nil, instructions: String? = nil, tools: [ASAAssistant.Tool]? = nil, fileIds: [String]? = nil, metadata: [String : String]? = nil) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
    }
}
