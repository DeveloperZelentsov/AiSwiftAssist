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

    /// Unix timestamp of message creation (in seconds).
    public let createdAt: Int

    /// Role of the entity creating the message (user, assistant).
    public let role: Role

    /// Message content (text, images, etc.).
    public let content: [Content]

    /// ID of the thread this message belongs to.
    public let threadId: String

    /// Optional: ID of the assistant that authored this message.
    public let assistantId: String?

    /// Optional: ID of the run associated with this message.
    public let runId: String?

    /// Optional: Attachments (files linked to specific tools).
    public let attachments: [Attachment]?

    /// Optional: Metadata (up to 16 key-value pairs).
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, object
        case createdAt = "created_at"
        case threadId = "thread_id"
        case role, content
        case assistantId = "assistant_id"
        case runId = "run_id"
        case attachments, metadata
    }

    /// Role type of the message sender.
    public enum Role: String, Codable, Sendable {
        case user
        case assistant
    }

    /// Content of the message (text, image URL, or image file).
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
                let textContent = try container.decode(TextContent.self, forKey: .text)
                self = .text(textContent)
            case "image_file":
                let imageFileContent = try container.decode(ImageFileContent.self, forKey: .imageFile)
                self = .imageFile(imageFileContent)
            case "image_url":
                let imageUrlContent = try container.decode(ImageURLContent.self, forKey: .imageUrl)
                self = .imageUrl(imageUrlContent)
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

    /// Represents text content in the message.
    public struct TextContent: Codable, Sendable {
        public let value: String
        public let annotations: [Annotation]?
    }

    /// Represents an image file in the message.
    public struct ImageFileContent: Codable, Sendable {
        public let fileId: String

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
        }
    }

    /// Represents an image URL in the message.
    public struct ImageURLContent: Codable, Sendable {
        public let url: String
    }

    /// Annotation details within text.
    public struct Annotation: Codable, Sendable {
        public let type: String
        public let text: String
        public let startIndex: Int
        public let endIndex: Int
        public let fileCitation: ASAFileCitation?
        public let filePath: ASAFilePath?

        enum CodingKeys: String, CodingKey {
            case type, text
            case startIndex = "start_index"
            case endIndex = "end_index"
            case fileCitation = "file_citation"
            case filePath = "file_path"
        }
    }

    public struct ASAFileCitation: Codable, Sendable {
        public let fileId: String
        public let quote: String

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
            case quote
        }
    }

    public struct ASAFilePath: Codable, Sendable {
        public let fileId: String

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
        }
    }

    /// Message attachment specifying associated tools.
    public struct Attachment: Codable, Sendable {
        public let fileId: String
        public let tools: [ToolType]

        enum CodingKeys: String, CodingKey {
            case fileId = "file_id"
            case tools
        }
    }

    public enum ToolType: String, Codable, Sendable {
        case codeInterpreter = "code_interpreter"
        case fileSearch = "file_search"
    }
}

// MARK: - Mock Data
extension ASAMessage {


    static let mockSimple = ASAMessage(
        id: "simple",
        object: "thread.message",
        createdAt: 1700000000,
        role: .user,
        content: [],
        threadId: "thread_1",
        assistantId: nil,
        runId: nil,
        attachments: nil,
        metadata: nil
    )

    static let mockPartial = ASAMessage(
        id: "partial",
        object: "thread.message",
        createdAt: 1700000100,
        role: .assistant,
        content: [.text(
            .init(
                value: "Hello",
                annotations: nil
            )
        )],
        threadId: "thread_2",
        assistantId: "asst_123",
        runId: nil,
        attachments: nil,
        metadata: ["env":"test"]
    )

    static let mocks: [ASAMessage] = [
        mockSimple,
        mockPartial
    ]
}
