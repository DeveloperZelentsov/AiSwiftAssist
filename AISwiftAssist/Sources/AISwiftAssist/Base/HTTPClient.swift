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
        var (data, response): (Data, URLResponse) = try await session.data(for: request)
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
//            if let emptyModel = AiEmpty() as? T {
//                return emptyModel
//            }
            if responseModel is Data.Type {
                return responseModel as! T
            }
            if let decodeData = data.decode(model: responseModel) {
                return decodeData
            } else {
                throw HTTPRequestError.decode
            }
        case 400:
//            if let error = data.decode(model: AiBaseError.self) {
//                throw HTTPRequestError.server(code: error.errorCode, message: error.message)
//            } else 
            if let decodeData = data.decode(model: ValidatorErrorResponse.self) {
                throw HTTPRequestError.validator(error: decodeData)
            }
            throw HTTPRequestError.unexpectedStatusCode(code: responseCode,
                                                        localized: responseCode.localStatusCode)

        case 401, 403: throw HTTPRequestError.unauthorizate
        default: throw HTTPRequestError.unexpectedStatusCode(code: responseCode,
                                                             localized: responseCode.localStatusCode)
        }
    }
}

// MARK: - Logging
private extension HTTPClient {

    /// Записывает детали переданного URLRequest в лог.
    /// - Parameters:
    ///   - request: Запрос, детали которого необходимо записать в лог.
    ///   - logger: Инструмент для логирования.
//    private func loggerRequest(request: URLRequest, logger: Logger) {
//        let body: [String: Any] = extractRequestBody(request: request)
//
//        logger.debug(
//                """
//                🛜 SEND REQUEST
//                ____________________________________________
//                URL: \(request.url?.absoluteString ?? "nil")
//                HEADERS:
//                \(request.allHTTPHeaderFields ?? [:], privacy: .private)
//                METHOD: \(request.httpMethod ?? "nil")
//                BODY:
//                \(body, privacy: .private)
//                ____________________________________________
//                """
//        )
//    }

//    private func loggerResponse(request: URLRequest, data: Data, logger: Logger) {
//        let answer: String = String(data: data, encoding: .utf8) ?? "Empty answer"
//
//        logger.debug(
//            """
//                🛜 Response
//                URL: \(request.url?.absoluteString ?? "nil")
//                Response:
//                \(answer)
//            """
//        )
//    }

    /// Извлекает тело запроса в виде словаря. Если данные не являются JSON или отсутствуют, вернет строковое представление данных.
    /// - Parameter request: URLRequest, из которого необходимо извлечь тело.
    /// - Returns: Тело запроса в виде словаря [String: Any] или строковое представление данных.
    private func extractRequestBody(request: URLRequest) -> [String: Any] {
        guard let data = request.httpBody else { return [:] }

        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any], !jsonObject.isEmpty {
            return jsonObject
        } else {
            return ["noJsonData": String(data: data, encoding: .utf8) ?? ""]
        }
    }
}
