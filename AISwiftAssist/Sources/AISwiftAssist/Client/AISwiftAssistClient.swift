//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public final class AISwiftAssistClient {

    public let assistantsApi: IAssistantsAPI
    public let messagesApi: IMessagesAPI
    public let modelsApi: IModelsAPI
    public let runsApi: IRunsAPI
    public let threadsApi: IThreadsAPI

    public init(config: AISwiftAssistConfig,
                baseScheme: String = Constants.baseScheme,
                baseHost: String = Constants.baseHost,
                path: String = Constants.path) {
        Constants.apiKey = config.apiKey
        Constants.organizationId = config.organizationId
        Constants.baseScheme = baseScheme
        Constants.baseHost = baseHost
        Constants.path = path
        self.assistantsApi = AssistantsAPI(urlSession: .shared)
        self.messagesApi = MessagesAPI(urlSession: .shared)
        self.modelsApi = ModelsAPI(urlSession: .shared)
        self.runsApi = RunsAPI(urlSession: .shared)
        self.threadsApi = ThreadsAPI(urlSession: .shared)
    }
}
