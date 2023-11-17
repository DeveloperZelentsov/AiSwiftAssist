//
//  File.swift
//  
//
//  Created by Alexey on 11/16/23.
//

import Foundation

/// A request structure for modifying a run.
public struct ASAModifyRunRequest: Codable {
    /// Optional: Set of 16 key-value pairs that can be attached to the run.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case metadata
    }
}
