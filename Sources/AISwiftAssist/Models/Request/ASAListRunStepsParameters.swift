//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// Parameters for listing run steps in a thread.
public struct ASAListRunStepsParameters: Codable {
    /// A limit on the number of objects to be returned.
    public let limit: Int?

    /// Sort order by the created_at timestamp of the objects.
    public let order: String?

    /// A cursor for use in pagination.
    public let after: String?

    /// A cursor for use in pagination.
    public let before: String?

    public init(limit: Int? = nil, order: String? = nil, after: String? = nil, before: String? = nil) {
        self.limit = limit
        self.order = order
        self.after = after
        self.before = before
    }
}
