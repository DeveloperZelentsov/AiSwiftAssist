//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents a request to create an assistant file.
public struct ASACreateAssistantFileRequest: Codable {
    /// A File ID (with purpose="assistants") that the assistant should use.
    /// Useful for tools like retrieval and code_interpreter that can access files.
    public let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    enum CodingKeys: String, CodingKey {
        case fileId = "file_id"
    }
}
