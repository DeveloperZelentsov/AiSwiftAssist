//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

enum ThreadsEndpoint {
    case createThread(ASACreateThreadRequest?)
    case retrieveThread(String)
    case modifyThread(String, ASAModifyThreadRequest)
    case deleteThread(String)

}

extension ThreadsEndpoint: CustomEndpoint {
    public var url: URL? {
        var urlComponents: URLComponents = .default
        urlComponents.queryItems = queryItems
        urlComponents.path = Constants.path + path
        return urlComponents.url
    }

    public var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem]?
        switch self {
        case .createThread, .retrieveThread, .deleteThread, .modifyThread: items = nil
        }
        return items
    }

    public var path: String {
        switch self {
        case .createThread: return "threads"
        case .retrieveThread(let threadId): return "threads/\(threadId)"
        case .modifyThread(let threadId, _): return "threads/\(threadId)"
        case .deleteThread(let threadId): return "threads/\(threadId)"
        }
    }

    public var method: HTTPRequestMethods {
        switch self {
        case .createThread: return .post
        case .retrieveThread: return .get
        case .modifyThread: return .post
        case .deleteThread: return .delete
        }
    }

    public var header: [String : String]? {
        let headers: [String: String] = ["OpenAI-Beta": "assistants=v1",
                                         "Content-Type": "application/json"]
        return headers
    }

    public var body: BodyInfo? {
        switch self {
        case .createThread(let request): return .init(object: request)
        case .retrieveThread: return nil
        case .modifyThread(_, let request): return .init(object: request)
        case .deleteThread: return nil
        }
    }
}
