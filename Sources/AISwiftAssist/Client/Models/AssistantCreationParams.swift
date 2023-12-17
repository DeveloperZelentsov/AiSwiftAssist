//
//  File.swift
//  
//
//  Created by Alexey on 11/17/23.
//

import Foundation

public struct AssistantCreationParams {
    
    public let model: ASAOpenAIModel
    public let name: String
    public let description: String
    public let instructions: String
    public let tools: [ASACreateAssistantRequest.Tool]?
    public let fileIds: [String]?
    public let metadata: [String: String]?

    public init(model: ASAOpenAIModel, name: String, description: String, instructions: String, tools: [ASACreateAssistantRequest.Tool]? = nil, fileIds: [String]? = nil, metadata: [String : String]? = nil) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
    }
}
