//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents an assistant file that can be used by the assistant.
public struct ASAAssistantFile: Codable {
    /// The identifier of the assistant file.
    public let id: String

    /// The object type, which is always 'assistant.file'.
    public let objectType: String

    /// The Unix timestamp (in seconds) for when the assistant file was created.
    public let createdAt: Int

    /// The identifier of the assistant to which this file belongs.
    public let assistantId: String

    enum CodingKeys: String, CodingKey {
        case id, objectType = "object", createdAt = "created_at", assistantId = "assistant_id"
    }
}
