//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents a response containing a list of run steps.
public struct ASARunStepsListResponse: Codable {
    /// The object type, which is always 'list'.
    public let object: String

    /// The list of run steps.
    public let data: [ASARunStep]

    /// Additional details about the list.
    public let hasMore: Bool
    public let firstId: String?
    public let lastId: String?

    enum CodingKeys: String, CodingKey {
        case data, object, hasMore = "has_more", firstId = "first_id", lastId = "last_id"
    }
}
