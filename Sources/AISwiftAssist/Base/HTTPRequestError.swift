//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public struct ValidatorErrorResponse: Codable {
    public let code: Int
    public let desc: String
}

/// Types of HTTP Request Errors
public enum HTTPRequestError: Error {
    /// Model decoding error
    case decode(String)
    /// URL validation error
    case invalidURL
    /// Error receiving response from server
    case noResponse
    /// Error getting data
    case request(localizedDiscription: String)
    /// End of current session error
    case unauthorizate
    /// Error for unexpected status codes
    case unexpectedStatusCode(code: Int, localized: String?)
    /// Server request processing error
    case defaultServerError(error: String)
    /// Loading data missing error
    case noBodyData
    /// Submitted data validation error
    case validator(error: ValidatorErrorResponse)
    /// A timeout occurs when an operation exceeds a set time limit
    case timeout
    /// Connection lost, occurs when an established network connection is broken
    case connectionLost
    /// No internet connection
    case notInternetConnection
    /// Server Errors
    case server(code: String, message: String?)
    /// Unknown error
    case unknown
}

extension HTTPRequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decode(let message):
            return "Decoding error\n\(message)"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No answer"
        case .request(let localizedDiscription):
            return localizedDiscription
        case .unauthorizate:
            return "Session ended"
        case .unexpectedStatusCode(let code, let local):
            return "unexpectedStatusCode: \(code) - " + (local ?? "")
        case .defaultServerError(error: let error):
            return "server error: " + error
        case .noBodyData:
            return "No data being transmitted"
        case .validator(let error):
            return "Validator error: \(error.desc)"
        case .unknown:
            return "Unknown error"
        case .timeout:
            return "Long connection wait"
        case .connectionLost:
            return "Connection lost"
        case .server(let code, let message):
            return "\(code)\n\(message ?? "Empty message")"
        case .notInternetConnection:
            return "No internet connection"
        }
    }
}
