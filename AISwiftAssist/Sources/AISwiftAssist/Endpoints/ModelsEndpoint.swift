//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

enum ModelsEndpoint {
    case getModels
    case retrieveModel(String)
    case deleteModel(String)
}

extension ModelsEndpoint: CustomEndpoint {
    public var url: URL? {
        var urlComponents: URLComponents = .default
        urlComponents.queryItems = queryItems
        urlComponents.path = Constants.path + path
        return urlComponents.url
    }

    public var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem]?
        switch self {
        case .getModels, .retrieveModel, .deleteModel: items = nil
        }
        return items
    }

    public var path: String {
        switch self {
        case .getModels: return "models"
        case .retrieveModel(let modelId): return "models/\(modelId)"
        case .deleteModel(let modelId): return "models/\(modelId)"
        }
    }

    public var method: HTTPRequestMethods {
        switch self {
        case .getModels, .retrieveModel: return .get
        case .deleteModel: return .delete
        }
    }

    public var header: [String : String]? {
        switch self {
        case .getModels, .retrieveModel, .deleteModel: nil
        }
    }

    public var body: BodyInfo? {
        switch self {
        case .getModels, .retrieveModel, .deleteModel: return nil
        }
    }
}
