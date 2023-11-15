//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Parameters for listing messages in a thread.
public struct ASAListMessagesParameters: Codable {
    /// Optional: A limit on the number of objects to be returned. Limit can range between 1 and 100.
    let limit: Int?

    /// Optional: Sort order by the created_at timestamp of the objects. 'asc' for ascending order and 'desc' for descending order.
    let order: String?

    /// Optional: A cursor for use in pagination. 'after' is an object ID that defines your place in the list.
    let after: String?

    /// Optional: A cursor for use in pagination. 'before' is an object ID that defines your place in the list.
    let before: String?

}
