//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents a message within a thread.
public struct ASAMessage: Codable {
    /// The identifier of the message, which can be referenced in API endpoints.
    public let id: String

    /// The object type, which is always 'thread.message'.
    public let object: String

    /// The Unix timestamp (in seconds) for when the message was created.
    public let createdAt: Int

    /// The thread ID that this message belongs to.
    public let threadId: String

    /// The entity that produced the message. One of 'user' or 'assistant'.
    public let role: String

    /// The content of the message in array of text and/or images.
    public let content: [ASAMessageContent]

    /// If applicable, the ID of the assistant that authored this message.
    public let assistantId: String?

    /// If applicable, the ID of the run associated with the authoring of this message.
    public let runId: String?

    /// A list of file IDs that the assistant should use. Useful for tools like retrieval and code_interpreter that can access files.
    /// A maximum of 10 files can be attached to a message.
    public let fileIds: [String]

    /// Optional: Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information
    /// about the object in a structured format. Keys can be a maximum of 64 characters long, and values can be a maximum of 512 characters long.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, object
        case createdAt = "created_at"
        case threadId = "thread_id"
        case role, content
        case assistantId = "assistant_id"
        case runId = "run_id"
        case fileIds = "file_ids"
        case metadata
    }
}
