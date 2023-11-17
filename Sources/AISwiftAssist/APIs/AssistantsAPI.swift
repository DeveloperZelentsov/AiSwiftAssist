//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Build assistants that can call models and use tools to perform tasks. [Link for Assistants](https://platform.openai.com/docs/api-reference/assistants)
public protocol IAssistantsAPI: AnyObject {
    
    /// Returns a list of assistants.
    /// - Parameter parameters: Parameters for the list of assistants.
    /// - Returns: A list of assistant objects.
    func get(with parameters: ASAListAssistantsParameters?) async throws -> [ASAAssistant]

    /// Create an assistant with a model and instructions.
    /// - Parameter createAssistant: The create assistant model.
    /// - Returns: An assistant object.
    func create(by createAssistant: ASACreateAssistantRequest) async throws -> ASAAssistant
    
    /// Retrieves an assistant.
    /// - Parameter assistantId: The ID of the assistant to retrieve.
    /// - Returns: The assistant object matching the specified ID.
    func retrieve(by assistantId: String) async throws -> ASAAssistant

    /// Modifies an assistant.
    /// - Parameters:
    ///   - assistantId: The ID of the assistant to modify.
    ///   - modifyAssistant: Object containing the properties to update.
    /// - Returns: The modified assistant object.
    func modify(by assistantId: String, modifyAssistant: ASAModifyAssistantRequest) async throws -> ASAAssistant

    /// Delete an assistant.
    /// - Parameter assistantId: The ID of the assistant to delete.
    /// - Returns: Deletion status
    func delete(by assistantId: String) async throws -> ASADeleteModelResponse
}

public final class AssistantsAPI: HTTPClient, IAssistantsAPI {

    let urlSession: URLSession

    public init(apiKey: String,
                baseScheme: String = Constants.baseScheme,
                baseHost: String = Constants.baseHost,
                path: String = Constants.path,
                urlSession: URLSession = .shared) {
        Constants.apiKey = apiKey
        Constants.baseScheme = baseScheme
        Constants.baseHost = baseHost
        Constants.path = path
        self.urlSession = urlSession
    }

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func get(with parameters: ASAListAssistantsParameters? = nil) async throws -> [ASAAssistant] {
        let endpoint = AssistantEndpoint.getAssistants(parameters)
        return try await sendRequest(endpoint: endpoint, responseModel: [ASAAssistant].self)
    }

    public func create(by createAssistant: ASACreateAssistantRequest) async throws -> ASAAssistant {
        let endpoint = AssistantEndpoint.createAssistant(createAssistant)
        return try await sendRequest(endpoint: endpoint, responseModel: ASAAssistant.self)
    }

    public func retrieve(by assistantId: String) async throws -> ASAAssistant {
        let endpoint = AssistantEndpoint.retrieveAssistant(assistantId)
        return try await sendRequest(endpoint: endpoint, responseModel: ASAAssistant.self)
    }

    public func modify(by assistantId: String, modifyAssistant: ASAModifyAssistantRequest) async throws -> ASAAssistant {
        let endpoint = AssistantEndpoint.modifyAssistant(assistantId, modifyAssistant)
        return try await sendRequest(endpoint: endpoint, responseModel: ASAAssistant.self)
    }

    public func delete(by assistantId: String) async throws -> ASADeleteModelResponse {
        let endpoint = AssistantEndpoint.deleteAssistant(assistantId)
        return try await sendRequest(endpoint: endpoint, responseModel: ASADeleteModelResponse.self)
    }

}

