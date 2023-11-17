//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Represents an execution run on a thread. [Link for Runs](https://platform.openai.com/docs/api-reference/runs)
public protocol IRunsAPI: AnyObject {
    
    /// Create a run.
    /// - Parameters:
    ///   - threadId: The ID of the thread to run.
    ///   - createRun: Object with parameters for creating a run.
    /// - Returns: A run object.
    func create(by threadId: String, createRun: ASACreateRunRequest) async throws -> ASARun
}

public final class RunsAPI: HTTPClient, IRunsAPI {

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

    public func create(by threadId: String, createRun: ASACreateRunRequest) async throws -> ASARun {
        let endpoint = RunsEndpoint.createRun(threadId, createRun)
        return try await sendRequest(endpoint: endpoint, responseModel: ASARun.self)
    }

}
