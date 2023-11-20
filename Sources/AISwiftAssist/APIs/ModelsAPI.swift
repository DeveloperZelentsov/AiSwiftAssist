//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Describes an OpenAI model offering that can be used with the API. [Link for Models](https://platform.openai.com/docs/api-reference/models)
public protocol IModelsAPI: AnyObject {
    
    /// Lists the currently available models, and provides basic information about each one such as the owner and availability.
    /// - Returns: A list of model objects.
    func get() async throws -> ASAModelsListResponse

    /// Retrieves a model instance, providing basic information about the model such as the owner and permissioning.
    /// - Parameter modelId: The ID of the model to use for this request
    /// - Returns: The model object matching the specified ID.
    func retrieve(by modelId: String) async throws -> ASAModel
    
    /// Delete a fine-tuned model. You must have the Owner role in your organization to delete a model.
    /// - Parameter modelId: The model to delete
    /// - Returns: Deletion status.
    func delete(by modelId: String) async throws -> ASADeleteModelResponse
}

public final class ModelsAPI: HTTPClient, IModelsAPI {

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

    public func get() async throws -> ASAModelsListResponse {
        let endpoint = ModelsEndpoint.getModels
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAModelsListResponse.self)
    }
    
    public func retrieve(by modelId: String) async throws -> ASAModel {
        let endpoint = ModelsEndpoint.retrieveModel(modelId)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAModel.self)
    }

    public func delete(by modelId: String) async throws -> ASADeleteModelResponse {
        let endpoint = ModelsEndpoint.deleteModel(modelId)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASADeleteModelResponse.self)
    }
}
