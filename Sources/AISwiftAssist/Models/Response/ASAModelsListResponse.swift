//
//  File.swift
//  
//
//  Created by Alexey on 11/17/23.
//

import Foundation

public struct ASAModelsListResponse: Codable {

    /// The object type, which is always "list".
    public let object: String

    /// The deletion status of the model.
    public let data: [ASAModel]

    enum CodingKeys: String, CodingKey {
        case object, data
    }
}
