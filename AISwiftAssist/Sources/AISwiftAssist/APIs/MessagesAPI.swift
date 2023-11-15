//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

/// Create messages within threads [Link for Messages](https://platform.openai.com/docs/api-reference/messages)
public protocol IMessagesAPI: AnyObject {

}

final class MessagesAPI: HTTPClient, IMessagesAPI {

    let urlSession: URLSession

    public init(apiKey: String,
                baseScheme: String = Constants.baseScheme,
                baseHost: String = Constants.baseHost,
                path: String = Constants.path,
                urlSession: URLSession = .shared) {
        Constants.apiKey = apiKey
        Constants.baseScheme = baseScheme
        Constants.baseHost = baseHost
        Constants.path = path
        self.urlSession = urlSession
    }

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

}
