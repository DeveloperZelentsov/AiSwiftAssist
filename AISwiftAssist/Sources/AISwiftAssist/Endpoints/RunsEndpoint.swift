//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

enum RunsEndpoint {
    case createRun(String, ASACreateRunRequest)
    case retrieveRun(String, String)
    case modifyRun(String, String, ASAModifyRunRequest)
    case listRuns(String, ASAListRunsParameters?)
}

extension RunsEndpoint: CustomEndpoint {

    public var url: URL? {
        var urlComponents: URLComponents = .default
        urlComponents.queryItems = queryItems
        urlComponents.path = Constants.path + path
        return urlComponents.url
    }

    public var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem]?
        switch self {
        case .createRun, .retrieveRun, .modifyRun: items = nil
        case .listRuns(_, let params): return Utils.createURLQueryItems(from: params)
        }
        return items
    }

    public var path: String {
        switch self {
        case .createRun(let threadId, _):
            return "threads/\(threadId)/runs"
        case .retrieveRun(let threadId, let runId):
            return "threads/\(threadId)/runs/\(runId)"
        case .modifyRun(let threadId, let runId, _):
            return "threads/\(threadId)/runs/\(runId)"
        case .listRuns(let threadId, _):
            return "threads/\(threadId)/runs"
        }
    }

    public var method: HTTPRequestMethods {
        switch self {
        case .createRun:
            return .post
        case .retrieveRun:
            return .get
        case .modifyRun:
            return .post
        case .listRuns:
            return .get
        }
    }

    public var header: [String : String]? {
        let headers: [String: String] = ["OpenAI-Beta": "assistants=v1",
                                         "Content-Type": "application/json"]
        return headers
    }

    public var body: BodyInfo? {
        switch self {
        case .createRun(_, let request):
            return .init(object: request)
        case .modifyRun(_, _, let request):
            return .init(object: request)
        case .retrieveRun, .listRuns:
            return nil
        }
    }
}

