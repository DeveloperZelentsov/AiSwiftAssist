//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Represents a response containing a list of assistant files.
public struct ASAMessageFilesListResponse: Codable {
    /// The object type, which is always 'list'.
    public let object: String

    /// The list of assistant files.
    public let data: [ASAMessageFile]

    /// The ID of the first file in the list.
    public let firstId: String

    /// The ID of the last file in the list.
    public let lastId: String

    /// Boolean indicating if there are more files available.
    public let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case data, firstId = "first_id", lastId = "last_id", hasMore = "has_more", object
    }
}
