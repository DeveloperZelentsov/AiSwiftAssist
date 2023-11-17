//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Parameters for listing assistants.
public struct ASAListAssistantsParameters: Encodable {
    
    /// Optional: A limit on the number of objects to be returned. Can range between 1 and 100. Defaults to 20.
    public let limit: Int?

    /// Optional: Sort order by the created_at timestamp of the objects. 'asc' for ascending order and 'desc' for descending order. Defaults to 'desc'.
    public let order: String?

    /// Optional: A cursor for use in pagination. 'after' is an object ID that defines your place in the list, to fetch the next page of the list.
    public let after: String?

    /// Optional: A cursor for use in pagination. 'before' is an object ID that defines your place in the list, to fetch the previous page of the list.
    public let before: String?

    public init(limit: Int? = nil, order: String? = nil, after: String? = nil, before: String? = nil) {
        self.limit = limit
        self.order = order
        self.after = after
        self.before = before
    }
}
