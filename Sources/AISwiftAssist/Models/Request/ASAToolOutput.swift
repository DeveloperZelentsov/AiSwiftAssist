//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents a tool output for submission.
public struct ASAToolOutput: Codable {
    /// The ID of the tool call.
    public let toolCallId: String

    /// The output of the tool call.
    public let output: String

    public init(toolCallId: String, output: String) {
        self.toolCallId = toolCallId
        self.output = output
    }

    enum CodingKeys: String, CodingKey {
        case toolCallId = "tool_call_id"
        case output
    }
}
