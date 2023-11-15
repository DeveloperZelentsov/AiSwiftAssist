//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation
/// Represents a thread that contains messages.
public struct ASAThread: Codable {
    /// The identifier of the thread, which can be referenced in API endpoints.
    public let id: String

    /// The object type, which is always 'thread'.
    public let object: String

    /// The Unix timestamp (in seconds) for when the thread was created.
    public let createdAt: Int

    /// Optional: Set of 16 key-value pairs that can be attached to the thread.
    /// This can be useful for storing additional information about the thread in a structured format.
    /// Keys can be a maximum of 64 characters long, and values can be a maximum of 512 characters long.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id, object
        case createdAt = "created_at"
        case metadata
    }
}
