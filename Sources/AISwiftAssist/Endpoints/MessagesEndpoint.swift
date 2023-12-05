//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

enum MessagesEndpoint {
    case createMessage(String, ASACreateMessageRequest)
    case retrieveMessage(String, String)
    case modifyMessage(String, String, ASAModifyMessageRequest)
    case listMessages(String, ASAListMessagesParameters?)
    case retrieveFile(String, String, String)
    case listFiles(String, String, ASAListMessagesParameters?)
}

extension MessagesEndpoint: CustomEndpoint {
    public var url: URL? {
        var urlComponents: URLComponents = .default
        urlComponents.queryItems = queryItems
        urlComponents.path = Constants.path + path
        return urlComponents.url
    }

    public var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem]?
        switch self {
        case .createMessage, .retrieveMessage, .modifyMessage, .retrieveFile: items = nil
        case .listMessages(_, let params): items = Utils.createURLQueryItems(from: params)
        case .listFiles(_, _, let params): items = Utils.createURLQueryItems(from: params)
        }
        return items
    }

    public var path: String {
        switch self {
        case .createMessage(let threadId, _): 
            return "threads/\(threadId)/messages"
        case .retrieveMessage(let threadId, let messageId):
            return "threads/\(threadId)/messages/\(messageId)"
        case .modifyMessage(let threadId, let messageId, _):
            return "threads/\(threadId)/messages/\(messageId)"
        case .listMessages(let threadId, _):
            return "threads/\(threadId)/messages"
        case .retrieveFile(let threadId, let messageId, let fileId):
            return "threads/\(threadId)/messages/\(messageId)/files/\(fileId)"
        case .listFiles(let threadId, let messageId, _):
            return "threads/\(threadId)/messages/\(messageId)/files"

        }
    }

    public var method: HTTPRequestMethods {
        switch self {
        case .createMessage: return .post
        case .retrieveMessage: return .get
        case .modifyMessage: return .post
        case .listMessages: return .get
        case .retrieveFile: return .get
        case .listFiles: return .get
        }
    }

    public var header: [String : String]? {
        let headers: [String: String] = ["OpenAI-Beta": "assistants=v1",
                                         "Content-Type": "application/json"]
        return headers
    }

    public var body: BodyInfo? {
        switch self {
        case .createMessage(_, let createMessageRequest): return .init(object: createMessageRequest)
        case .modifyMessage(_, _, let request): return .init(object: request)
        case .retrieveMessage: return nil
        case .listMessages: return nil
        case .retrieveFile: return nil
        case .listFiles: return nil
        }
    }
}
