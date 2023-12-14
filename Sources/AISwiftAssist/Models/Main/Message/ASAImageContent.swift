//
//  File.swift
//  
//
//  Created by Alexey on 12/13/23.
//

import Foundation

/// Represents an image file in the content of a message.
public struct ASAImageContent: Codable {
    /// The File ID of the image in the message content.
    public let file_id: String

    enum CodingKeys: String, CodingKey {
        case file_id
    }
}
