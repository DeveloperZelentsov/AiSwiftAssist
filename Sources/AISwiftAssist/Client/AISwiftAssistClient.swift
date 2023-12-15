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

extension AISwiftAssistClient {
    /// Creates an assistant and thread based on the provided parameters.
    public func createAssistantAndThread(with params: AssistantCreationParams) async throws -> AssistantAndThreadConfig {
        let modelsResponse = try await modelsApi.get()
        guard let model = modelsResponse.data.first(where: { $0.id == params.model.rawValue }) else {
            throw NSError(domain: "AISwiftAssistClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Model not found"])
        }

        let createAssistantRequest = ASACreateAssistantRequest(asaModel: model,
                                                               name: params.name,
                                                               description: params.description,
                                                               instructions: params.instructions,
                                                               tools: params.tools,
                                                               fileIds: params.fileIds,
                                                               metadata: params.metadata)
        let assistant = try await assistantsApi.create(by: createAssistantRequest)

        let threadRequest = ASACreateThreadRequest(messages: nil)
        let thread = try await threadsApi.create(by: threadRequest)

        return AssistantAndThreadConfig(assistant: assistant, thread: thread)
    }
}
