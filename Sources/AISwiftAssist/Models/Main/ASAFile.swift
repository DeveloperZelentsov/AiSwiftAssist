//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents a document that has been uploaded to OpenAI.
public struct ASAFile: Codable {
    /// The file identifier, which can be referenced in the API endpoints.
    public let id: String

    /// The size of the file, in bytes.
    public let bytes: Int

    /// The Unix timestamp (in seconds) for when the file was created.
    public let createdAt: Int

    /// The name of the file.
    public let filename: String

    /// The object type, which is always 'file'.
    public let object: String

    /// The intended purpose of the file. Supported values are 'fine-tune', 'fine-tune-results', 'assistants', and 'assistants_output'.
    public let purpose: String

    enum CodingKeys: String, CodingKey {
        case id, bytes
        case createdAt = "created_at"
        case filename, object, purpose
    }
}
