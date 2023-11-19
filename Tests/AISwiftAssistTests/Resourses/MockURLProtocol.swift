//
//  File.swift
//  
//
//  Created by Alexey on 11/19/23.
//

import Foundation

class MockURLProtocol: URLProtocol {
    // Handler to test the request and return a mock response.
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        // To check if this protocol can handle the given request.
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Return the original request as the canonical version.
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }

        do {
            // Call handler with received request and capture the tuple of response and data.
            let (response, data) = try handler(request)

            // Send received response to the client.
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                // Send received data to the client.
                client?.urlProtocol(self, didLoad: data)
            }

            // Notify request has been finished.
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            // Notify received error.
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        // This is called if the request gets canceled or completed.
    }
}


