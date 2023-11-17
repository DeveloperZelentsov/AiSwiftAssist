//
//  File.swift
//  
//
//  Created by Alexey on 11/16/23.
//

import Foundation

public struct AISwiftAssistConfig {

    public let apiKey: String
    public let organizationId: String?

    public init(apiKey: String,
                organizationId: String? = nil) {
        self.apiKey = apiKey
        self.organizationId = organizationId
    }

}
