//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents a message within a thread.
public struct ASAMessage: Codable, Sendable {
    /// Unique identifier of the message.
    public let id: String

    /// Object type, always "thread.message".
    public let object: String

    /// Unix timestamp (in seconds) when the message was created.
    public let createdAt: Int

    /// ID of the thread this message belongs to.
    public let threadId: String

    /// The status of the message (in_progress, incomplete, completed).
    public let status: Status

    /// Details about why the message is incomplete (if applicable).
    public let incompleteDetails: IncompleteDetails?

    /// Unix timestamp (in seconds) when the message was completed.
    public let completedAt: Int?

    /// Unix timestamp (in seconds) when the message was marked incomplete.
    public let incompleteAt: Int?

    /// Role of the entity that produced the message (user or assistant).
    public let role: Role

    /// Content of the message (array of text and/or images).
    public let content: [Content]

    /// ID of the assistant that authored this message (if applicable).
    public let assistantId: String?

    /// ID of the run associated with the creation of this message.
    public let runId: String?

    /// Attachments (files attached to the message and their tools).
    public let attachments: [Attachment]?

    /// Metadata (max 16 key-value pairs).
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, object, status, role, content, attachments, metadata
        case createdAt = "created_at"
        case threadId = "thread_id"
        case incompleteDetails = "incomplete_details"
        case completedAt = "completed_at"
        case incompleteAt = "incomplete_at"
        case assistantId = "assistant_id"
        case runId = "run_id"
    }

    /// Status of the message.
    public enum Status: String, Codable, Sendable {
        case inProgress = "in_progress"
        case incomplete
        case completed
    }

    /// Details about why the message is incomplete.
    public struct IncompleteDetails: Codable, Sendable {
        /// Reason the message is incomplete.
        public let reason: String
    }

    /// Role type of the message sender.
    public enum Role: String, Codable, Sendable {
        case user
        case assistant
    }

    /// Content of the message.
    public enum Content: Codable, Sendable {
        case text(TextContent)
        case imageFile(ImageFileContent)
        case imageUrl(ImageURLContent)

        enum CodingKeys: String, CodingKey {
            case type, text, imageFile = "image_file", imageUrl = "image_url"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)

            switch type {
            case "text":
                self = .text(try container.decode(TextContent.self, forKey: .text))
            case "image_file":
                self = .imageFile(try container.decode(ImageFileContent.self, forKey: .imageFile))
            case "image_url":
                self = .imageUrl(try container.decode(ImageURLContent.self, forKey: .imageUrl))
            default:
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown content type")
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .text(let textContent):
                try container.encode("text", forKey: .type)
                try container.encode(textContent, forKey: .text)
            case .imageFile(let imageFileContent):
                try container.encode("image_file", forKey: .type)
                try container.encode(imageFileContent, forKey: .imageFile)
            case .imageUrl(let imageUrlContent):
                try container.encode("image_url", forKey: .type)
                try container.encode(imageUrlContent, forKey: .imageUrl)
            }
        }
    }

    /// Represents text content.
    public struct TextContent: Codable, Sendable {
        public let value: String
        public let annotations: [Annotation]?
    }

    /// Represents an image file content.
    public struct ImageFileContent: Codable, Sendable {
        public let fileId: String
        public let detail: String?

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
            case detail
        }
    }

    /// Represents an image URL content.
    public struct ImageURLContent: Codable, Sendable {
        public let url: URL
        public let detail: String?
    }

    /// Annotation details within text content.
    public struct Annotation: Codable, Sendable {
        public let type: String
        public let text: String
        public let startIndex: Int
        public let endIndex: Int
        public let fileCitation: FileCitation?
        public let filePath: FilePath?

        enum CodingKeys: String, CodingKey {
            case type, text
            case startIndex = "start_index"
            case endIndex = "end_index"
            case fileCitation = "file_citation"
            case filePath = "file_path"
        }
    }

    /// Citation pointing to a specific file quote.
    public struct FileCitation: Codable, Sendable {
        public let fileId: String
        public let quote: String

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
            case quote
        }
    }

    /// URL for the file generated by the assistant.
    public struct FilePath: Codable, Sendable {
        public let fileId: String

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
        }
    }

    /// Represents a file attachment.
    public struct Attachment: Codable, Sendable {
        public let fileId: String
        public let tools: [ToolType]

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
            case tools
        }
    }

    /// Type of tool associated with an attachment.
    public enum ToolType: String, Codable, Sendable {
        case codeInterpreter = "code_interpreter"
        case fileSearch = "file_search"
    }
}
