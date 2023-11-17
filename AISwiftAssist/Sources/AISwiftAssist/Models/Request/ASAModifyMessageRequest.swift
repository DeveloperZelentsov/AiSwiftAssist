//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// A request structure for modifying a message in a thread.
public struct ASAModifyMessageRequest: Codable {
    
    /// Optional: Set of 16 key-value pairs that can be attached to the message.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case metadata
    }

    public init(metadata: [String : String]? = nil) {
        self.metadata = metadata
    }
}
