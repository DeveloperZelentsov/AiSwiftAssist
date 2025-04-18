//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// A request structure for modifying a thread.
public struct ASAModifyThreadRequest: Codable, Sendable {
    /// Optional: Resources available to the assistant's tools in this thread.
    public let toolResources: ASAThread.ToolResources?

    /// Optional: Metadata associated with the thread (max 16 key-value pairs).
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case toolResources = "tool_resources"
        case metadata
    }

    public init(toolResources: ASAThread.ToolResources? = nil,
                metadata: [String: String]? = nil) {
        self.toolResources = toolResources
        self.metadata = metadata
    }
}
