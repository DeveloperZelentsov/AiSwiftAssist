//
//  AssistantsAPITests.swift
//  
//
//  Created by Alexey on 11/19/23.
//

import Foundation
import Testing
@testable import AISwiftAssist

struct AssistantsAPITests {

    private let api: any IAssistantsAPI = {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let api = AssistantsAPI(urlSession: session)
        return api
    }()

    @Test
    func testGetAssistants_Success() async throws {


        await MockURLProtocol.setHandler ({ request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Self.list.data(using: .utf8)!)
        }, for: "getAssistants")

        let result = try await api.get(with: nil)

        #expect(result.data.count == 7)
        #expect(result.data.first?.id == "asst_advanced_full")
        #expect(result.data.first?.name == "Advanced Assistant")
        #expect(result.data.first?.model == "gpt-4-turbo")
        #expect(result.hasMore == false)
    }

    @Test
    func testRetrieveAssistant_Success() async throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let assistantAPI = AssistantsAPI(urlSession: session)

        await MockURLProtocol.setHandler ({ request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Self.retrieve.data(using: .utf8)!)
        }, for: "retrieveAssistant")

        let assistant = try await assistantAPI.retrieve(by: "asst_advanced_full")

        #expect(assistant.id == "asst_advanced_full")
        #expect(assistant.name == "Advanced Assistant")
        #expect(assistant.model == "gpt-4-turbo")
        #expect(assistant.tools.count == 3)
    }

    @Test
    func testModifyAssistant_Success() async throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let assistantAPI = AssistantsAPI(urlSession: session)

        await MockURLProtocol.setHandler ({ request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Self.modify.data(using: .utf8)!)
        }, for: "modifyAssistant")

        let modifyRequest = ASAModifyAssistantRequest(
            model: "gpt-4",
            name: "Advanced",
            instructions: "You are a professional assistant with advanced functionality, tool support, and strict output controls."
        )

        let assistant = try await assistantAPI.modify(
            by: "asst_advanced_full",
            modifyAssistant: modifyRequest
        )

        #expect(assistant.id == "asst_advanced_full")
        #expect(assistant.name == "Advanced")
        #expect(assistant.model == "gpt-4")
    }
}
