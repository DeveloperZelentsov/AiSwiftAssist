//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPRequestMethods { get }
    var header: [String: String]? { get }
    var body: BodyInfo? { get }
}

protocol CustomEndpoint: Endpoint {
    var queryItems: [URLQueryItem]? { get }
    var path: String { get }
}

struct BodyInfo {
    private let bodyDict: [String: String]?
    private let bodyData: Data?

    public var data: Data? {
        if let bodyDict = bodyDict {
            return try? JSONEncoder().encode(bodyDict)
        }
        if let bodyData = bodyData {
            return bodyData
        }
        return nil
    }

    public init(bodyDict: [String: String]?)  {
        self.bodyData = nil
        self.bodyDict = bodyDict
    }

    public init(bodyData: Data?) {
        self.bodyDict = nil
        self.bodyData = bodyData
    }

    public init<T: Encodable>(object: T) {
        self.bodyDict = nil
        self.bodyData = try? JSONEncoder().encode(object)
    }

    /// If you need to initialize body with empty parameters
    public init() {
        self.bodyData = nil
        self.bodyDict = nil
    }

}
