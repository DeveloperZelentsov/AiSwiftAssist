//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents an execution run on a thread.
public struct ASARun: Codable {
    /// The identifier of the run, which can be referenced in API endpoints.
    public let id: String

    /// The object type, which is always 'thread.run'.
    public let object: String

    /// The Unix timestamp (in seconds) for when the run was created.
    public let createdAt: Int

    /// The ID of the thread that was executed on as a part of this run.
    public let threadId: String

    /// The ID of the assistant used for execution of this run.
    public let assistantId: String

    /// The status of the run, which can be either queued, in_progress, requires_action, cancelling, cancelled, failed, completed, or expired.
    public let status: String

    /// Details on the action required to continue the run. Will be null if no action is required.
    public let requiredAction: RequiredAction?

    /// The last error associated with this run. Will be null if there are no errors.
    public let lastError: LastError?

    /// The Unix timestamp (in seconds) for when the run will expire.
    public let expiresAt: Int?

    /// The Unix timestamp (in seconds) for when the run was started. Null if not started.
    public let startedAt: Int?

    /// The Unix timestamp (in seconds) for when the run was cancelled. Null if not cancelled.
    public let cancelledAt: Int?

    /// The Unix timestamp (in seconds) for when the run failed. Null if not failed.
    public let failedAt: Int?

    /// The Unix timestamp (in seconds) for when the run was completed. Null if not completed.
    public let completedAt: Int?

    /// The model that the assistant used for this run.
    public let model: String

    /// The instructions that the assistant used for this run.
    public let instructions: String?

    /// The list of tools that the assistant used for this run.
    /// Tools can be of types code_interpreter, retrieval, or function.
    public let tools: [Tool]

    /// The list of File IDs the assistant used for this run.
    public let fileIds: [String]

    /// Set of 16 key-value pairs that can be attached to the run. Useful for storing additional information.
    public let metadata: [String: String]?

    /// Represents the required action details for the run to continue.
    public struct RequiredAction: Codable {
        /// For now, this is always 'submit_tool_outputs'.
        public let type: String

        /// Details on the tool outputs needed for this run to continue.
        public let submitToolOutputs: SubmitToolOutputs

        enum CodingKeys: String, CodingKey {
            case type
            case submitToolOutputs = "submit_tool_outputs"
        }

        /// Represents the tool outputs needed for this run to continue.
        public struct SubmitToolOutputs: Codable {
            /// A list of the relevant tool calls.
            public let toolCalls: [ToolCall]

            /// Represents a single tool call.
            public struct ToolCall: Codable {
                /// The ID of the tool call.
                public let id: String

                /// The type of tool call the output is required for. For now, this is always 'function'.
                public let type: String

                /// The function definition.
                public let function: Function

                /// Represents the function definition.
                public struct Function: Codable {
                    /// The name of the function.
                    public let name: String

                    /// The arguments that the model expects you to pass to the function.
                    public let arguments: String
                }
            }
        }
    }

    public struct LastError: Codable {
        /// One of 'server_error' or 'rate_limit_exceeded'.
        public let code: String

        /// A human-readable description of the error.
        public let message: String
    }

    /// Represents a tool enabled on the assistant.
    public struct Tool: Codable {
        /// The type of the tool (e.g., code_interpreter, retrieval, function).
        public let type: String
    }

    enum CodingKeys: String, CodingKey {
        case id, object
        case createdAt = "created_at"
        case threadId = "thread_id"
        case assistantId = "assistant_id"
        case status, requiredAction = "required_action"
        case lastError = "last_error"
        case expiresAt = "expires_at"
        case startedAt = "started_at"
        case cancelledAt = "cancelled_at"
        case failedAt = "failed_at"
        case completedAt = "completed_at"
        case model, instructions, tools
        case fileIds = "file_ids"
        case metadata
    }
}
