//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Create threads that assistants can interact with. [Link for Threads](https://platform.openai.com/docs/api-reference/threads)
public protocol IThreadsAPI: AnyObject {
    
    /// Create a thread.
    /// - Parameter createThreads: Object with parameters for creating a thread.
    /// - Returns: A thread object.
    func create(by createThreads: ASACreateThreadRequest?) async throws -> ASAThread

    /// Retrieves a thread by its ID.
    /// - Parameter threadId: The ID of the thread to retrieve.
    /// - Returns: The thread object matching the specified ID.
    func retrieve(threadId: String) async throws -> ASAThread

    /// Modifies a thread by its ID.
    /// - Parameters:
    ///   - threadId: The ID of the thread to modify.
    ///   - modifyThread: Object with parameters for modifying a thread.
    /// - Returns: The modified thread object.
    func modify(threadId: String, with modifyThread: ASAModifyThreadRequest) async throws -> ASAThread

    /// Deletes a thread by its ID.
    /// - Parameter threadId: The ID of the thread to delete.
    /// - Returns: A boolean indicating the deletion status.
    func delete(threadId: String) async throws -> ASADeleteModelResponse
}

public final class ThreadsAPI: HTTPClient, IThreadsAPI {
    
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

    public func create(by createThreads: ASACreateThreadRequest?) async throws -> ASAThread {
        let endpoint = ThreadsEndpoint.createThread(createThreads)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAThread.self)
    }

    public func retrieve(threadId: String) async throws -> ASAThread {
        let endpoint = ThreadsEndpoint.retrieveThread(threadId)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAThread.self)
    }

    public func modify(threadId: String, with modifyThread: ASAModifyThreadRequest) async throws -> ASAThread {
        let endpoint = ThreadsEndpoint.modifyThread(threadId, modifyThread)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAThread.self)
    }

    public func delete(threadId: String) async throws -> ASADeleteModelResponse {
        let endpoint = ThreadsEndpoint.deleteThread(threadId)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASADeleteModelResponse.self)
    }
}
