//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents an execution run on a thread.
public struct ASARun: Codable, Sendable {
    /// Unique identifier of the run.
    public let id: String

    /// Object type, always "thread.run".
    public let object: String

    /// Unix timestamp (in seconds) when the run was created.
    public let createdAt: Int

    /// ID of the thread associated with this run.
    public let threadId: String

    /// ID of the assistant executing this run.
    public let assistantId: String

    /// Current status of the run (queued, in_progress, requires_action, cancelling, cancelled, failed, completed, incomplete, expired).
    public let status: Status

    /// Details of actions required to continue the run (if applicable).
    public let requiredAction: RequiredAction?

    /// Last error encountered during the run (if applicable).
    public let lastError: LastError?

    /// Unix timestamp (in seconds) when the run expires.
    public let expiresAt: Int?

    /// Unix timestamp (in seconds) when the run was started.
    public let startedAt: Int?

    /// Unix timestamp (in seconds) when the run was cancelled.
    public let cancelledAt: Int?

    /// Unix timestamp (in seconds) when the run failed.
    public let failedAt: Int?

    /// Unix timestamp (in seconds) when the run was completed.
    public let completedAt: Int?

    /// Model used for this run.
    public let model: String

    /// Instructions provided to the assistant.
    public let instructions: String?

    /// Tools enabled for the run.
    public let tools: [Tool]

    /// Metadata associated with the run.
    public let metadata: [String: String]?

    /// Usage statistics for the run (if applicable).
    public let usage: Usage?

    enum CodingKeys: String, CodingKey {
        case id, object, status, model, instructions, tools, metadata, usage
        case createdAt = "created_at"
        case threadId = "thread_id"
        case assistantId = "assistant_id"
        case requiredAction = "required_action"
        case lastError = "last_error"
        case expiresAt = "expires_at"
        case startedAt = "started_at"
        case cancelledAt = "cancelled_at"
        case failedAt = "failed_at"
        case completedAt = "completed_at"
    }

    /// Possible statuses of the run.
    public enum Status: String, Codable, Sendable {
        case queued, inProgress = "in_progress", requiresAction = "requires_action", cancelling, cancelled, failed, completed, incomplete, expired
    }

    /// Represents the action required to continue the run.
    public struct RequiredAction: Codable, Sendable {
        /// Action type, currently always "submit_tool_outputs".
        public let type: String

        /// Details of required tool outputs.
        public let submitToolOutputs: SubmitToolOutputs

        enum CodingKeys: String, CodingKey {
            case type
            case submitToolOutputs = "submit_tool_outputs"
        }

        public struct SubmitToolOutputs: Codable, Sendable {
            /// Relevant tool calls for the action.
            public let toolCalls: [ToolCall]

            enum CodingKeys: String, CodingKey {
                case toolCalls = "tool_calls"
            }

            public struct ToolCall: Codable, Sendable {
                /// ID of the tool call.
                public let id: String

                /// Type of tool call, currently always "function".
                public let type: String

                /// Function details for the tool call.
                public let function: Function

                public struct Function: Codable, Sendable {
                    /// Name of the function.
                    public let name: String

                    /// Arguments for the function.
                    public let arguments: String
                }
            }
        }
    }

    /// Represents the last error encountered during the run.
    public struct LastError: Codable, Sendable {
        /// Error code (server_error, rate_limit_exceeded, invalid_prompt).
        public let code: String

        /// Human-readable description of the error.
        public let message: String
    }

    /// Represents a tool used during the run.
    public struct Tool: Codable, Sendable {
        /// Type of tool (e.g., "code_interpreter", "file_search", "function").
        public let type: String
    }

    /// Usage statistics for the run.
    public struct Usage: Codable, Sendable {
        /// Number of completion tokens used.
        public let completionTokens: Int

        /// Number of prompt tokens used.
        public let promptTokens: Int

        /// Total number of tokens used.
        public let totalTokens: Int

        enum CodingKeys: String, CodingKey {
            case completionTokens = "completion_tokens"
            case promptTokens = "prompt_tokens"
            case totalTokens = "total_tokens"
        }
    }
}
