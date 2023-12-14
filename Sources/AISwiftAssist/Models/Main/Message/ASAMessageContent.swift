//
//  File.swift
//  
//
//  Created by Alexey on 12/13/23.
//

import Foundation

public enum ASAMessageContent: Codable {
    case image(ASAImageContent)
    case text(ASATextContent)

    enum CodingKeys: String, CodingKey {
        case type, imageFile = "image_file", text
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "image_file":
            let imageContent = try container.decode(ASAImageContent.self, forKey: .imageFile)
            self = .image(imageContent)
        case "text":
            let textContent = try container.decode(ASATextContent.self, forKey: .text)
            self = .text(textContent)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid type")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .image(let imageContent):
            try container.encode("image_file", forKey: .type)
            try container.encode(imageContent, forKey: .imageFile)
        case .text(let textContent):
            try container.encode("text", forKey: .type)
            try container.encode(textContent, forKey: .text)
        }
    }
}


