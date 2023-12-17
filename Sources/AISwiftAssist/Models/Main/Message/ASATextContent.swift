//
//  File.swift
//  
//
//  Created by Alexey on 12/13/23.
//

import Foundation

/// Represents the text content of a message.
public struct ASATextContent: Codable {
    /// The value of the text.
    public let value: String

    /// Optional: Annotations
    public let annotations: [ASAAnnotation]?
}

public struct ASAAnnotation: Codable {
    let type: String
    let text: String
    let startIndex: Int
    let endIndex: Int
    let fileCitation: ASAFileCitation?
    let filePath: ASAFilePath?

    enum CodingKeys: String, CodingKey {
        case type, text, startIndex = "start_index", endIndex = "end_index", fileCitation = "file_citation", filePath = "file_path"
    }
}

public struct ASAFileCitation: Codable {
    public let fileId: String
    public let quote: String

    enum CodingKeys: String, CodingKey {
        case fileId = "file_id", quote
    }
}

public struct ASAFilePath: Codable {
    public let fileId: String

    enum CodingKeys: String, CodingKey {
        case fileId = "file_id"
    }
}
