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
    public let content: [MessageContent]

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

    /// Represents the content of a message.
    public struct MessageContent: Codable {
        /// The type of the content, e.g., 'text', 'image_file', etc.
        public let type: String

        /// The text content of the message.
        public let text: TextContent?

        /// The image file content of the message.
        public let imageFile: ImageFile?

        /// The file citation content of the message.
        public let fileCitation: FileCitation?

        /// The file path content of the message.
        public let filePath: FilePath?

        enum CodingKeys: String, CodingKey {
            case type
            case text
            case imageFile = "image_file"
            case fileCitation = "file_citation"
            case filePath = "file_path"
        }

        /// Represents the text content of a message.
        public struct TextContent: Codable {
            /// The value of the text.
            public let value: String

            /// Optional: Annotations for the text.
            public let annotations: [String]?
        }

        /// Represents an image file in the content of a message.
        public struct ImageFile: Codable {
            /// The File ID of the image in the message content.
            public let fileId: String

            enum CodingKeys: String, CodingKey {
                case fileId = "file_id"
            }
        }

        /// Represents a file citation within the message.
        public struct FileCitation: Codable {
            /// The text in the message content that needs to be replaced.
            public let text: String

            /// The specific quote in the file.
            public let quote: String

            /// The ID of the specific File the citation is from.
            public let fileId: String

            /// The start index of the citation.
            public let startIndex: Int

            /// The end index of the citation.
            public let endIndex: Int

            enum CodingKeys: String, CodingKey {
                case text, quote
                case fileId = "file_id"
                case startIndex = "start_index"
                case endIndex = "end_index"
            }
        }

        /// Represents a file path in the content of a message.
        public struct FilePath: Codable {
            /// The text in the message content that needs to be replaced.
            public let text: String

            /// The ID of the file that was generated.
            public let fileId: String

            /// The start index of the file path.
            public let startIndex: Int

            /// The end index of the file path.
            public let endIndex: Int

            enum CodingKeys: String, CodingKey {
                case text
                case fileId = "file_id"
                case startIndex = "start_index"
                case endIndex = "end_index"
            }
        }
    }
}
