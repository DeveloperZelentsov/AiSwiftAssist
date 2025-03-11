//
//  File.swift
//  
//
//  Created by Alexey on 11/19/23.
//

import Foundation

actor RequestHandlerStorage {
    private var requestHandlers: [String: (@Sendable (URLRequest) async throws -> (HTTPURLResponse, Data))] = [:]

    func setHandler(_ handler: @Sendable @escaping (URLRequest) async throws -> (HTTPURLResponse, Data), for key: String) async {
        requestHandlers[key] = handler
    }

    func executeHandler(for request: URLRequest, for key: String) async throws -> (HTTPURLResponse, Data) {
        guard let handler = requestHandlers[key] else {
            throw MockURLProtocolError.noRequestHandler
        }
        return try await handler(request)
    }
}

final class MockURLProtocol: URLProtocol, @unchecked Sendable {

    private static let requestHandlerStorage = RequestHandlerStorage()

    static func setHandler(_ handler: @Sendable @escaping (URLRequest) async throws -> (HTTPURLResponse, Data), for key: String) async {
        await requestHandlerStorage.setHandler ({ request in
            try await handler(request)
        }, for: key)
    }

    func executeHandler(for request: URLRequest, key: String) async throws -> (HTTPURLResponse, Data) {
        return try await Self.requestHandlerStorage.executeHandler(for: request, for: key)
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        Task {
            do {
                guard let key = request.value(forHTTPHeaderField: "ForTest") else {
                    client?.urlProtocol(self, didFailWithError: MockURLProtocolError.invalidURL)
                    return
                }
                let (response, data) = try await self.executeHandler(for: request, key: key)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }

    }

    override func stopLoading() {}
}


enum MockURLProtocolError: Error {
    case noRequestHandler
    case invalidURL
}
