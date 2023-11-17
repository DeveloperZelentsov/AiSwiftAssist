//
//  File.swift
//  
//
//  Created by Alexey on 11/16/23.
//

import Foundation

/// A request structure for creating a run in a thread.
public struct ASACreateRunRequest: Codable {
    
    /// The ID of the assistant to use to execute this run.
    public let assistantId: String

    /// Optional: The ID of the Model to be used to execute this run.
    public let model: String?

    /// Optional: Override the default system message of the assistant.
    public let instructions: String?

    /// Optional: Override the tools the assistant can use for this run.
    public let tools: [Tool]?

    /// Optional: Set of 16 key-value pairs that can be attached to the run.
    public let metadata: [String: String]?

    /// Represents a tool that can be used by the assistant during the run.
    public struct Tool: Codable {
        /// The type of tool being defined: 'code_interpreter', 'retrieval', 'function'.
        public let type: String

        /// Additional details for the 'function' tool type.
        public let function: Function?

        /// Represents a function tool's details.
        public struct Function: Codable {
            /// Optional: A description of what the function does.
            public let description: String?

            /// The name of the function to be called.
            public let name: String

            /// The parameters the functions accepts, described as a JSON Schema object.
            public let parameters: [String: String]

            enum CodingKeys: String, CodingKey {
                case description, name, parameters
            }
        }

        enum CodingKeys: String, CodingKey {
            case type, function
        }
    }

    enum CodingKeys: String, CodingKey {
        case assistantId = "assistant_id"
        case model, instructions, tools, metadata
    }

    public init(assistantId: String, model: String? = nil, instructions: String? = nil, tools: [ASACreateRunRequest.Tool]? = nil, metadata: [String : String]? = nil) {
        self.assistantId = assistantId
        self.model = model
        self.instructions = instructions
        self.tools = tools
        self.metadata = metadata
    }
}
