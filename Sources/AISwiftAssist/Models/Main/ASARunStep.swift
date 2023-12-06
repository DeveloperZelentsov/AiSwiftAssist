//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents a step in the execution of a run.
public struct ASARunStep: Codable {
    /// The identifier of the run step, which can be referenced in API endpoints.
    let id: String

    /// The object type, which is always `thread.run.step`.
    let object: String

    /// The Unix timestamp (in seconds) for when the run step was created.
    let createdAt: Int

    /// The ID of the assistant associated with the run step.
    let assistantId: String

    /// The ID of the thread that was run.
    let threadId: String

    /// The ID of the run that this run step is a part of.
    let runId: String

    /// The type of run step, which can be either `message_creation` or `tool_calls`.
    let type: String

    /// The status of the run step, which can be either `in_progress`, `cancelled`, `failed`, `completed`, or `expired`.
    let status: String

    /// The details of the run step.
    let stepDetails: StepDetails

    /// The last error associated with this run step. Will be `null` if there are no errors.
    let lastError: LastError?

    /// The Unix timestamp (in seconds) for when the run step expired. A step is considered expired if the parent run is expired.
    let expiredAt: Int?

    /// The Unix timestamp (in seconds) for when the run step was cancelled.
    let cancelledAt: Int?

    /// The Unix timestamp (in seconds) for when the run step failed.
    let failedAt: Int?

    /// The Unix timestamp (in seconds) for when the run step completed.
    let completedAt: Int?

    /// A set of 16 key-value pairs that can be attached to an object.
    let metadata: [String: String]?

    /// A structure to represent the step details.
    struct StepDetails: Codable {
        let type: String // This can be 'message_creation' or 'tool_calls'.
        let messageCreation: MessageCreation?
        let toolCalls: [ToolCall]?

        /// A structure to represent the message creation details.
        struct MessageCreation: Codable {
            let messageId: String

            enum CodingKeys: String, CodingKey {
                case messageId = "message_id"
            }
        }

        /// A structure to represent the tool calls.
        struct ToolCall: Codable {
            let id: String
            let type: String // This can be 'code_interpreter', 'retrieval', or 'function'.
            let details: ToolCallDetails?

            enum CodingKeys: String, CodingKey {
                case id, type, details
            }

            /// A structure to represent the details of a tool call.
            struct ToolCallDetails: Codable {
                let codeInterpreter: CodeInterpreter?
                let retrieval: Retrieval?
                let function: FunctionCall?

                enum CodingKeys: String, CodingKey {
                    case codeInterpreter = "code_interpreter"
                    case retrieval
                    case function
                }

                /// A structure to represent the code interpreter tool call.
                struct CodeInterpreter: Codable {
                    let id: String
                    let type: String // This will always be 'code_interpreter'.
                    let input: String
                    let outputs: [CodeInterpreterOutput]

                    enum CodingKeys: String, CodingKey {
                        case id, type, input, outputs
                    }

                    /// A structure to represent the outputs of a code interpreter tool call.
                    struct CodeInterpreterOutput: Codable {
                        let type: String // Can be 'logs' or 'image'.
                        let logs: String?
                        let image: ImageOutput?

                        enum CodingKeys: String, CodingKey {
                            case type, logs, image
                        }

                        /// A structure to represent the image output.
                        struct ImageOutput: Codable {
                            let fileId: String

                            enum CodingKeys: String, CodingKey {
                                case fileId = "file_id"
                            }
                        }
                    }
                }

                /// A structure to represent the retrieval tool call.
                struct Retrieval: Codable {
                    // For now, it's always an empty object.
                }

                /// A structure to represent the function tool call.
                struct FunctionCall: Codable {
                    let name: String
                    let arguments: String
                    let output: String?

                    enum CodingKeys: String, CodingKey {
                        case name, arguments, output
                    }
                }
            }
        }

        enum CodingKeys: String, CodingKey {
            case type
            case messageCreation = "message_creation"
            case toolCalls = "tool_calls"
        }
    }

    /// A structure to represent the last error.
    struct LastError: Codable {
        /// One of `server_error` or `rate_limit_exceeded`.
        let code: String

        /// A human-readable description of the error.
        let message: String
    }

    /// Coding keys to match the JSON property names.
    enum CodingKeys: String, CodingKey {
        case id, object, type, status, lastError, metadata
        case stepDetails = "step_details"
        case createdAt = "created_at"
        case assistantId = "assistant_id"
        case threadId = "thread_id"
        case runId = "run_id"
        case expiredAt = "expired_at"
        case cancelledAt = "cancelled_at"
        case failedAt = "failed_at"
        case completedAt = "completed_at"
    }
}
