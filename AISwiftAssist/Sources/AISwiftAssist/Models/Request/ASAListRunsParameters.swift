//
//  File.swift
//  
//
//  Created by Alexey on 11/17/23.
//

import Foundation

/// Parameters for listing runs in a thread.
public struct ASAListRunsParameters: Codable {
    
    /// Optional: A limit on the number of objects to be returned.
    public let limit: Int?

    /// Optional: Sort order by the created_at timestamp of the objects.
    public let order: String?

    /// Optional: A cursor for use in pagination.
    public let after: String?

    /// Optional: A cursor for use in pagination.
    public let before: String?
    
    public init(limit: Int? = nil, order: String? = nil, after: String? = nil, before: String? = nil) {
        self.limit = limit
        self.order = order
        self.after = after
        self.before = before
    }
}
