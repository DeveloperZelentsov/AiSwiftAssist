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
    
    /// Returns a list of runs belonging to a thread.
    /// - Parameters:
    ///   - threadId: The ID of the thread the run belongs to.
    ///   - parameters: Parameters for the list of runs.
    /// - Returns: A list of run objects.
    func listRuns(by threadId: String, parameters: ASAListRunsParameters?) async throws -> ASARunsListResponse
    
    /// Modifies a run.
    /// - Parameters:
    ///   - threadId: The ID of the thread that was run.
    ///   - runId: The ID of the run to modify.
    ///   - modifyRun: A request structure for modifying a run.
    /// - Returns: The modified run object matching the specified ID.
    func modify(by threadId: String, runId: String, modifyRun: ASAModifyRunRequest) async throws -> ASARun
    
    /// Retrieves a run.
    /// - Parameters:
    ///   - threadId: The ID of the thread that was run.
    ///   - runId: The ID of the run to retrieve.
    /// - Returns: The run object matching the specified ID.
    func retrieve(by threadId: String, runId: String) async throws -> ASARun
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
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASARun.self)
    }

    public func listRuns(by threadId: String, parameters: ASAListRunsParameters?) async throws -> ASARunsListResponse {
        let endpoint = RunsEndpoint.listRuns(threadId, parameters)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASARunsListResponse.self)
    }

    public func modify(by threadId: String, runId: String, modifyRun: ASAModifyRunRequest) async throws -> ASARun {
        let endpoint = RunsEndpoint.modifyRun(threadId, runId, modifyRun)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASARun.self)
    }

    public func retrieve(by threadId: String, runId: String) async throws -> ASARun {
        let endpoint = RunsEndpoint.retrieveRun(threadId, runId)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASARun.self)
    }

}
