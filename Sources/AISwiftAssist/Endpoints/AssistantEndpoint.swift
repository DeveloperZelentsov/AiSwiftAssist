//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

enum AssistantEndpoint {
    case getAssistants(ASAListAssistantsParameters?)
    case createAssistant(ASACreateAssistantRequest)
    case retrieveAssistant(String)
    case modifyAssistant(String, ASAModifyAssistantRequest)
    case deleteAssistant(String)
}

extension AssistantEndpoint: CustomEndpoint {
    public var url: URL? {
        var urlComponents: URLComponents = .default
        urlComponents.queryItems = queryItems
        urlComponents.path = Constants.path + path
        return urlComponents.url
    }

    public var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem]?
        switch self {
        case .createAssistant, .deleteAssistant, .retrieveAssistant, .modifyAssistant: items = nil
        case .getAssistants(let params): items = Utils.createURLQueryItems(from: params)
        }
        return items
    }

    public var path: String {
        switch self {
        case .createAssistant, .getAssistants: return "assistants"
        case .retrieveAssistant(let assistantId): return "assistants/\(assistantId)"
        case .modifyAssistant(let assistantId, _): return "assistants/\(assistantId)"
        case .deleteAssistant(let assistantId): return "assistants/\(assistantId)"
        }
    }

    public var method: HTTPRequestMethods {
        switch self {
        case .getAssistants: return .get
        case .createAssistant: return .post
        case .retrieveAssistant: return .get
        case .modifyAssistant: return .post
        case .deleteAssistant: return .delete
        }
    }

    public var header: [String : String]? {
        let headers: [String: String] = ["OpenAI-Beta": "assistants=v1",
                                         "Content-Type": "application/json"]
        return headers
    }

    public var body: BodyInfo? {
        switch self {
        case .createAssistant(let createAssistant): return .init(object: createAssistant)
        case .modifyAssistant(_, let request): return .init(object: request)
        case .deleteAssistant, .retrieveAssistant, .getAssistants: return nil

        }
    }
}
