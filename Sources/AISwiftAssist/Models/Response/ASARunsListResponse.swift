//
//  File 2.swift
//  
//
//  Created by Alexey on 11/17/23.
//

import Foundation

/// Represents a response containing a list of runs.
public struct ASARunsListResponse: Codable {
    /// The object type, which is always 'list'.
    public let object: String

    /// The list of runs.
    public let data: [ASARun]

    /// The ID of the first run in the list.
    public let firstId: String

    /// The ID of the last run in the list.
    public let lastId: String

    /// Indicates whether there are more runs to fetch.
    public let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case object, data
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }
}
