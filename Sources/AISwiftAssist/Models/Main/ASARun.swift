//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents an execution run on a thread.
public struct ASARun: Codable, Sendable {

    /// The identifier, which can be referenced in API endpoints.
    public let id: String

    /// The object type, always `thread.run`.
    public let object: String

    /// The Unix timestamp (in seconds) when the run was created.
    public let createdAt: Int

    /// The ID of the thread that was executed as part of this run.
    public let threadId: String

    /// The ID of the assistant used for execution of this run.
    public let assistantId: String

    /// The status of the run.
    public let status: Status

    /// Details on the action required to continue the run. Null if no action is required.
    public let requiredAction: RequiredAction?

    /// The last error associated with this run. Null if there are no errors.
    public let lastError: LastError?

    /// The Unix timestamp (in seconds) when the run will expire.
    public let expiresAt: Int?

    /// The Unix timestamp (in seconds) when the run started.
    public let startedAt: Int?

    /// The Unix timestamp (in seconds) when the run was cancelled.
    public let cancelledAt: Int?

    /// The Unix timestamp (in seconds) when the run failed.
    public let failedAt: Int?

    /// The Unix timestamp (in seconds) when the run was completed.
    public let completedAt: Int?

    /// The model used by the assistant for this run.
    public let model: String

    /// Instructions used by the assistant for this run.
    public let instructions: String?

    /// Tools used by the assistant for this run.
    public let tools: [Tool]

    /// Set of key-value pairs with additional information about the object.
    public let metadata: [String: String]?

    /// Usage statistics related to the run. Null if the run is not in a terminal state.
    public let usage: Usage?

    /// The sampling temperature used for this run. Defaults to 1 if not set.
    public let temperature: Double?

    /// The nucleus sampling value used for this run. Defaults to 1 if not set.
    public let topP: Double?

    /// Maximum number of completion tokens allowed for this run.
    public let maxCompletionTokens: Int?

    /// Maximum number of prompt tokens allowed for this run.
    public let maxPromptTokens: Int?

    /// Controls how a thread will be truncated prior to the run.
    public let truncationStrategy: TruncationStrategy?

    /// Specifies the format that the model must output.
    public let responseFormat: ResponseFormat?

    /// Controls which (if any) tool is called by the model.
    public let toolChoice: ToolChoice?

    /// Enables parallel function calling during tool use.
    public let parallelToolCalls: Bool?

    /// Details on why the run is incomplete. Null if the run is not incomplete.
    public let incompleteDetails: IncompleteDetails?

    public enum Status: String, Codable, Sendable {
        case queued
        case inProgress = "in_progress"
        case requiresAction = "requires_action"
        case cancelling
        case cancelled
        case failed
        case completed
        case incomplete
        case expired
    }

    public struct RequiredAction: Codable, Sendable {
        public let type: String
        public let submitToolOutputs: SubmitToolOutputs

        public struct SubmitToolOutputs: Codable, Sendable {
            public let toolCalls: [ToolCall]

            public struct ToolCall: Codable, Sendable {
                public let id: String
                public let type: String
                public let function: Function

                public struct Function: Codable, Sendable {
                    public let name: String
                    public let arguments: String
                }
            }

            enum CodingKeys: String, CodingKey {
                case toolCalls = "tool_calls"
            }
        }

        enum CodingKeys: String, CodingKey {
            case type
            case submitToolOutputs = "submit_tool_outputs"
        }
    }

    public struct LastError: Codable, Sendable {
        public let code: String
        public let message: String
    }

    public struct Tool: Codable, Sendable {
        public let type: ToolType
        public let function: FunctionTool?
        public let fileSearch: FileSearchTool?

        public enum ToolType: String, Codable, Sendable {
            case codeInterpreter = "code_interpreter"
            case fileSearch = "file_search"
            case function
        }

        public struct FunctionTool: Codable, Sendable {
            public let name: String
            public let description: String?
            public let parameters: [String: AnyCodable]?
            public let strict: Bool?
        }

        public struct FileSearchTool: Codable, Sendable {
            public let maxNumResults: Int?
            public let rankingOptions: RankingOptions?

            public struct RankingOptions: Codable, Sendable {
                public let ranker: String?
                public let scoreThreshold: Double?

                enum CodingKeys: String, CodingKey {
                    case ranker
                    case scoreThreshold = "score_threshold"
                }
            }

            enum CodingKeys: String, CodingKey {
                case maxNumResults = "max_num_results"
                case rankingOptions = "ranking_options"
            }
        }
    }

    public struct Usage: Codable, Sendable {
        public let completionTokens: Int
        public let promptTokens: Int
        public let totalTokens: Int

        enum CodingKeys: String, CodingKey {
            case completionTokens = "completion_tokens"
            case promptTokens = "prompt_tokens"
            case totalTokens = "total_tokens"
        }
    }

    public struct TruncationStrategy: Codable, Sendable {
        public let type: String
        public let lastMessages: Int?

        enum CodingKeys: String, CodingKey {
            case type
            case lastMessages = "last_messages"
        }
    }

    public enum ResponseFormat: Codable, Sendable {
        case auto
        case text
        case jsonObject
        case jsonSchema(JSONSchema)

        public struct JSONSchema: Codable, Sendable {
            public let name: String
            public let description: String?
            public let schema: [String: AnyCodable]?
            public let strict: Bool?
        }

        enum CodingKeys: String, CodingKey {
            case type
            case jsonSchema = "json_schema"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "auto": self = .auto
            case "text": self = .text
            case "json_object": self = .jsonObject
            case "json_schema":
                let schema = try container.decode(JSONSchema.self, forKey: .jsonSchema)
                self = .jsonSchema(schema)
            default:
                self = .auto
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .auto: try container.encode("auto", forKey: .type)
            case .text: try container.encode("text", forKey: .type)
            case .jsonObject: try container.encode("json_object", forKey: .type)
            case .jsonSchema(let schema):
                try container.encode("json_schema", forKey: .type)
                try container.encode(schema, forKey: .jsonSchema)
            }
        }
    }

    public enum ToolChoice: Codable, Sendable {
        case none
        case auto
        case required
        case specificTool(SpecificTool)

        public struct SpecificTool: Codable, Sendable {
            public let type: String
            public let function: SpecificFunction?

            public struct SpecificFunction: Codable, Sendable {
                public let name: String
            }
        }
    }

    public struct IncompleteDetails: Codable, Sendable {
        public let reason: String
    }

    enum CodingKeys: String, CodingKey {
        case id, object, createdAt = "created_at", threadId = "thread_id", assistantId = "assistant_id",
             status, requiredAction = "required_action", lastError = "last_error",
             expiresAt = "expires_at", startedAt = "started_at", cancelledAt = "cancelled_at",
             failedAt = "failed_at", completedAt = "completed_at", model, instructions, tools, metadata,
             usage, temperature, topP = "top_p", maxCompletionTokens = "max_completion_tokens",
             maxPromptTokens = "max_prompt_tokens", truncationStrategy = "truncation_strategy",
             responseFormat = "response_format", toolChoice = "tool_choice",
             parallelToolCalls = "parallel_tool_calls", incompleteDetails = "incomplete_details"
    }
}
