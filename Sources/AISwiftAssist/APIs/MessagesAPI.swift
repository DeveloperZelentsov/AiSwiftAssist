//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Create messages within threads [Link for Messages](https://platform.openai.com/docs/api-reference/messages)
public protocol IMessagesAPI: AnyObject, Sendable {

    /// Returns a list of messages for a given thread.
    /// - Parameters:
    ///   - threadId: The ID of the thread the messages belong to.
    ///   - parameters: Parameters for the list of messages.
    /// - Returns: A list of message objects.
    func getMessages(by threadId: String, parameters: ASAListMessagesParameters?) async throws -> ASAMessagesListResponse

    /// Create a message.
    /// - Parameters:
    ///   - threadId: The ID of the thread to create a message for.
    ///   - createMessage: Object with parameters for creating a message.
    /// - Returns: A message object.
    func create(by threadId: String, createMessage: ASACreateMessageRequest) async throws -> ASAMessage

    /// Retrieve a message.
    /// - Parameters:
    ///   - threadId: The ID of the thread to which this message belongs.
    ///   - messageId: The ID of the message to retrieve.
    /// - Returns: The message object matching the specified ID.
    func retrieve(by threadId: String, messageId: String) async throws -> ASAMessage

    /// Modifies a message.
    /// - Parameters:
    ///   - threadId: The ID of the thread to which this message belongs.
    ///   - messageId: The ID of the message to modify.
    ///   - modifyMessage: Object with parameters for modifying a message.
    /// - Returns: The modified message object.
    func modify(by threadId: String, messageId: String, modifyMessage: ASAModifyMessageRequest) async throws -> ASAMessage

}

public actor MessagesAPI: HTTPClient, IMessagesAPI {

    let urlSession: URLSession

    public init(
        config: AISwiftAssistConfig,
        constants: AISwiftAssistConstants = .default,
        urlSession: URLSession = .shared
    ) {
        Constants.config = config
        Constants.constants = constants
        self.urlSession = urlSession
    }

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func getMessages(by threadId: String, parameters: ASAListMessagesParameters?) async throws -> ASAMessagesListResponse {
        let endpoint = MessagesEndpoint.listMessages(threadId, parameters)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAMessagesListResponse.self)
    }

    public func create(by threadId: String, createMessage: ASACreateMessageRequest) async throws -> ASAMessage {
        let endpoint = MessagesEndpoint.createMessage(threadId, createMessage)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAMessage.self)
    }

    public func retrieve(by threadId: String, messageId: String) async throws -> ASAMessage {
        let endpoint = MessagesEndpoint.retrieveMessage(threadId, messageId)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAMessage.self)
    }

    public func modify(by threadId: String, messageId: String, modifyMessage: ASAModifyMessageRequest) async throws -> ASAMessage {
        let endpoint = MessagesEndpoint.modifyMessage(threadId, messageId, modifyMessage)
        return try await sendRequest(session: urlSession, endpoint: endpoint, responseModel: ASAMessage.self)
    }

}
