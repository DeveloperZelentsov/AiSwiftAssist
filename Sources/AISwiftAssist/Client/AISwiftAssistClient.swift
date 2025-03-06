//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public actor AISwiftAssistClient: Sendable {

    public let assistantsApi: IAssistantsAPI
    public let messagesApi: IMessagesAPI
    public let modelsApi: IModelsAPI
    public let runsApi: IRunsAPI
    public let threadsApi: IThreadsAPI

    public init(
        config: AISwiftAssistConfig,
        constants: AISwiftAssistConstants = .default,
        urlSession: URLSession = .shared
    ) {
        Constants.config = config
        Constants.constants = constants
        self.assistantsApi = AssistantsAPI(urlSession: urlSession)
        self.messagesApi = MessagesAPI(urlSession: urlSession)
        self.modelsApi = ModelsAPI(urlSession: urlSession)
        self.runsApi = RunsAPI(urlSession: urlSession)
        self.threadsApi = ThreadsAPI(urlSession: urlSession)
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
