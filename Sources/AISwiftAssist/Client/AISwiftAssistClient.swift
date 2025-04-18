//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public actor AISwiftAssistClient: Sendable {

    public nonisolated let assistantsApi: any IAssistantsAPI
    public nonisolated let messagesApi: any IMessagesAPI
    public nonisolated let runsApi: any IRunsAPI
    public nonisolated let threadsApi: any IThreadsAPI

    public init(
        config: AISwiftAssistConfig,
        constants: AISwiftAssistConstants = .default,
        urlSession: URLSession = .shared
    ) {
        Constants.config = config
        Constants.constants = constants
        self.assistantsApi = AssistantsAPI(urlSession: urlSession)
        self.messagesApi = MessagesAPI(urlSession: urlSession)
        self.runsApi = RunsAPI(urlSession: urlSession)
        self.threadsApi = ThreadsAPI(urlSession: urlSession)
    }

}
