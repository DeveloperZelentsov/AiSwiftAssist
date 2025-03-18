//
//  File.swift
//  
//
//  Created by Alexey on 11/16/23.
//

import Foundation
import Foundation

/// Represents a request for creating a run on a thread.
public struct ASACreateRunRequest: Codable, Sendable {

    /// The ID of the assistant to use to execute this run.
    public let assistantId: String

    /// Optional. The model ID to override the assistant's default model.
    public let model: String?

    /// Optional. Overrides the assistant's instructions for this run.
    public let instructions: String?

    /// Optional. Appends additional instructions at the end of the run's instructions.
    public let additionalInstructions: String?

    /// Optional. Additional messages added to the thread before creating the run.
    public let additionalMessages: [AdditionalMessage]?

    /// Optional. Overrides the tools available to the assistant for this run.
    public let tools: [ASARun.Tool]?

    /// Optional. Controls which (if any) tool is called by the model.
    public let toolChoice: ASARun.ToolChoice?

    /// Optional. Enables parallel function calling during tool use. Defaults to `true`.
    public let parallelToolCalls: Bool?

    /// Optional. The sampling temperature (0–2). Defaults to `1`.
    public let temperature: Double?

    /// Optional. Alternative to temperature sampling, controlling nucleus sampling (0–1). Defaults to `1`.
    public let topP: Double?

    /// Optional. Maximum number of completion tokens allowed for this run.
    public let maxCompletionTokens: Int?

    /// Optional. Maximum number of prompt tokens allowed for this run.
    public let maxPromptTokens: Int?

    /// Optional. Controls how the thread is truncated before running.
    public let truncationStrategy: ASARun.TruncationStrategy?

    /// Optional. Constrains reasoning effort. Supported values: `low`, `medium`, `high`. Defaults to `medium`. (o-series models only)
    public let reasoningEffort: String?

    /// Optional. Specifies the format of the model's output.
    public let responseFormat: ASARun.ResponseFormat?

    /// Optional. Streams events during the run as server-sent events if set to `true`.
    public let stream: Bool?

    /// Optional. Additional structured data (up to 16 key-value pairs) attached to the run.
    public let metadata: [String: String]?

    // MARK: - Additional Types

    /// Represents an additional message to add to the thread.
    public struct AdditionalMessage: Codable, Sendable {

        /// The role of the message sender (`user` or `assistant`).
        public let role: String

        /// The message content (text or content parts).
        public let content: Content

        /// Optional. Files attached to the message.
        public let attachments: [Attachment]?

        // MARK: - Nested types

        /// Represents content of the message.
        public enum Content: Codable, Sendable {
            case text(String)
            case parts([ContentPart])

            public init(from decoder: Decoder) throws {
                if let text = try? decoder.singleValueContainer().decode(String.self) {
                    self = .text(text)
                } else {
                    let parts = try decoder.singleValueContainer().decode([ContentPart].self)
                    self = .parts(parts)
                }
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .text(let text):
                    try container.encode(text)
                case .parts(let parts):
                    try container.encode(parts)
                }
            }
        }

        /// Represents a content part (text or image).
        public enum ContentPart: Codable, Sendable {
            case text(TextContent)
            case imageFile(ImageFileContent)
            case imageURL(ImageURLContent)

            // Nested structures
            public struct TextContent: Codable, Sendable {
                public let type: String // Always "text"
                public let text: String
            }

            public struct ImageFileContent: Codable, Sendable {
                public let type: String // Always "image_file"
                public let imageFile: ImageFile

                public struct ImageFile: Codable, Sendable {
                    public let fileId: String

                    enum CodingKeys: String, CodingKey {
                        case fileId = "file_id"
                    }
                }

                enum CodingKeys: String, CodingKey {
                    case type
                    case imageFile = "image_file"
                }
            }

            public struct ImageURLContent: Codable, Sendable {
                public let type: String // Always "image_url"
                public let imageURL: ImageURL

                public struct ImageURL: Codable, Sendable {
                    public let url: String
                    public let detail: String?

                    enum CodingKeys: String, CodingKey {
                        case url, detail
                    }
                }

                enum CodingKeys: String, CodingKey {
                    case type
                    case imageURL = "image_url"
                }
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(String.self, forKey: .type)
                switch type {
                case "text":
                    self = .text(try TextContent(from: decoder))
                case "image_file":
                    self = .imageFile(try ImageFileContent(from: decoder))
                case "image_url":
                    self = .imageURL(try ImageURLContent(from: decoder))
                default:
                    throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown type")
                }
            }

            public func encode(to encoder: Encoder) throws {
                switch self {
                case .text(let content):
                    try content.encode(to: encoder)
                case .imageFile(let content):
                    try content.encode(to: encoder)
                case .imageURL(let content):
                    try content.encode(to: encoder)
                }
            }

            enum CodingKeys: String, CodingKey {
                case type
            }
        }

        /// Represents an attachment of a file to the message.
        public struct Attachment: Codable, Sendable {
            /// ID of the attached file.
            public let fileId: String

            /// Tools associated with this attachment.
            public let tools: [AttachmentTool]?

            public struct AttachmentTool: Codable, Sendable {
                /// Type of tool: `code_interpreter`, `file_search`.
                public let type: String
            }

            enum CodingKeys: String, CodingKey {
                case fileId = "file_id"
                case tools
            }
        }
    }

    // MARK: - Initializer

    public init(
        assistantId: String,
        model: String? = nil,
        instructions: String? = nil,
        additionalInstructions: String? = nil,
        additionalMessages: [AdditionalMessage]? = nil,
        tools: [ASARun.Tool]? = nil,
        toolChoice: ASARun.ToolChoice? = nil,
        parallelToolCalls: Bool? = true,
        temperature: Double? = 1.0,
        topP: Double? = 1.0,
        maxCompletionTokens: Int? = nil,
        maxPromptTokens: Int? = nil,
        truncationStrategy: ASARun.TruncationStrategy? = nil,
        reasoningEffort: String? = "medium",
        responseFormat: ASARun.ResponseFormat? = .auto,
        stream: Bool? = nil,
        metadata: [String: String]? = nil
    ) {
        self.assistantId = assistantId
        self.model = model
        self.instructions = instructions
        self.additionalInstructions = additionalInstructions
        self.additionalMessages = additionalMessages
        self.tools = tools
        self.toolChoice = toolChoice
        self.parallelToolCalls = parallelToolCalls
        self.temperature = temperature
        self.topP = topP
        self.maxCompletionTokens = maxCompletionTokens
        self.maxPromptTokens = maxPromptTokens
        self.truncationStrategy = truncationStrategy
        self.reasoningEffort = reasoningEffort
        self.responseFormat = responseFormat
        self.stream = stream
        self.metadata = metadata
    }

    enum CodingKeys: String, CodingKey {
        case assistantId = "assistant_id"
        case model
        case instructions
        case additionalInstructions = "additional_instructions"
        case additionalMessages = "additional_messages"
        case tools
        case toolChoice = "tool_choice"
        case parallelToolCalls = "parallel_tool_calls"
        case temperature
        case topP = "top_p"
        case maxCompletionTokens = "max_completion_tokens"
        case maxPromptTokens = "max_prompt_tokens"
        case truncationStrategy = "truncation_strategy"
        case reasoningEffort = "reasoning_effort"
        case responseFormat = "response_format"
        case stream
        case metadata
    }
}
