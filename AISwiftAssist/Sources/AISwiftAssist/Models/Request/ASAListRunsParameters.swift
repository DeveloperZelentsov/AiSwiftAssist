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
    let limit: Int?

    /// Optional: Sort order by the created_at timestamp of the objects.
    let order: String?

    /// Optional: A cursor for use in pagination.
    let after: String?

    /// Optional: A cursor for use in pagination.
    let before: String?

}
