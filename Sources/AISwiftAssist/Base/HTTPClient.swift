//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

protocol HTTPClient: AnyObject {
    func sendRequest<T: Decodable>(session: URLSession,
                                   endpoint: any Endpoint,
                                   responseModel: T.Type) async throws -> T
}

extension HTTPClient {

    func sendRequest<T: Decodable>(
        session: URLSession = .shared,
        endpoint: any Endpoint,
        responseModel: T.Type) async throws -> T {
        let request = try createRequest(by: endpoint)
        let (data, response): (Data, URLResponse) = try await session.data(for: request)
        return try handlingDataTask(data: data,
                                response: response,
                                responseModel: responseModel)

    }

    private func createRequest(by endpoint: any Endpoint) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw HTTPRequestError.invalidURL
        }
        var request: URLRequest = .init(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        if request.allHTTPHeaderFields == nil {
            request.allHTTPHeaderFields = ["Authorization": "Bearer \(Constants.apiKey)"]
        } else {
            request.allHTTPHeaderFields?["Authorization"] = "Bearer \(Constants.apiKey)"
        }
        request.httpBody = endpoint.body?.data

        return request
    }

    /// A helper method that handles the response from a request.
    func handlingDataTask<T: Decodable>(
        data: Data,
        response: URLResponse,
        responseModel: T.Type
    ) throws -> T {
        guard let responseCode = (response as? HTTPURLResponse)?.statusCode else {
            throw HTTPRequestError.noResponse
        }
        switch responseCode {
        case 200...299:
            if responseModel is Data.Type {
                return responseModel as! T
            }
            do {
                let decodeData = try data.decode(model: responseModel)
                return decodeData
            } catch {
                throw HTTPRequestError.decode(error.localizedDescription)
            }
        case 400:
            do {
                let decodeData = try data.decode(model: ValidatorErrorResponse.self)
                throw HTTPRequestError.validator(error: decodeData)
            } catch {
                throw HTTPRequestError.unexpectedStatusCode(code: responseCode,
                                                            localized: responseCode.localStatusCode)
            }
        case 401, 403: throw HTTPRequestError.unauthorizate
        default: throw HTTPRequestError.unexpectedStatusCode(code: responseCode,
                                                             localized: responseCode.localStatusCode)
        }
    }
}
