//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// A request structure for modifying a thread.
public struct ASAModifyThreadRequest: Codable {
    /// Optional: Set of 16 key-value pairs that can be attached to the thread.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case metadata
    }
}
