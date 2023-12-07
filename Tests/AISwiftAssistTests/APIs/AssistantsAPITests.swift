//
//  AssistantsAPITests.swift
//  
//
//  Created by Alexey on 11/19/23.
//

import XCTest
@testable import AISwiftAssist

final class AssistantsAPITests: XCTestCase {

    var assistantsAPI: IAssistantsAPI!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        assistantsAPI = AssistantsAPI(urlSession: mockURLSession)
    }

    override func tearDown() {
        assistantsAPI = nil
        super.tearDown()
    }

    func testGetAssistants() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.list.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let response: ASAAssistantsListResponse = try await assistantsAPI.get(with: nil)

            XCTAssertNotNil(response)
            XCTAssertEqual(response.object, "list")
            XCTAssertEqual(response.data.count, 3)
            XCTAssertEqual(response.firstId, "asst_abc123")
            XCTAssertEqual(response.lastId, "asst_abc789")
            XCTAssertFalse(response.hasMore)

            // Checks for specific assistants
            XCTAssertEqual(response.data[0].id, "asst_abc123")
            XCTAssertEqual(response.data[0].objectType, "assistant")
            XCTAssertEqual(response.data[0].createdAt, 1698982736)
            XCTAssertEqual(response.data[0].name, "Coding Tutor")
            XCTAssertEqual(response.data[0].model, "gpt-4")
            XCTAssertEqual(response.data[0].instructions, "You are a helpful assistant designed to make me better at coding!")

            XCTAssertEqual(response.data[1].id, "asst_abc456")
            XCTAssertEqual(response.data[1].objectType, "assistant")
            XCTAssertEqual(response.data[1].createdAt, 1698982718)
            XCTAssertEqual(response.data[1].name, "My Assistant")
            XCTAssertEqual(response.data[1].model, "gpt-4")
            XCTAssertEqual(response.data[1].instructions, "You are a helpful assistant designed to make me better at coding!")

            XCTAssertEqual(response.data[2].id, "asst_abc789")
            XCTAssertEqual(response.data[2].objectType, "assistant")
            XCTAssertEqual(response.data[2].createdAt, 1698982643)
            XCTAssertNil(response.data[2].name)
            XCTAssertEqual(response.data[2].model, "gpt-4")
            XCTAssertNil(response.data[2].instructions)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testCreateAssistant() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.create.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let createRequest = ASACreateAssistantRequest(model: "gpt-4", 
                                                          name: "Math Tutor",
                                                          instructions: "You are a personal math tutor. When asked a question, write and run Python code to answer the question.")

            let assistant: ASAAssistant = try await assistantsAPI.create(by: createRequest)

            // Checks
            XCTAssertEqual(assistant.id, "asst_abc123")
            XCTAssertEqual(assistant.objectType, "assistant")
            XCTAssertEqual(assistant.createdAt, 1698984975)
            XCTAssertEqual(assistant.name, "Math Tutor")
            XCTAssertEqual(assistant.model, "gpt-4")
            XCTAssertEqual(assistant.instructions, "You are a personal math tutor. When asked a question, write and run Python code to answer the question.")
            XCTAssertEqual(assistant.tools.count, 1)
            XCTAssertEqual(assistant.tools.first?.type, "code_interpreter")
            XCTAssertTrue(assistant.fileIds.isEmpty)
            XCTAssertTrue(assistant.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testRetrieveAssistant() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.retrieve.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let assistantId = "asst_abc123"
            let assistant: ASAAssistant = try await assistantsAPI.retrieve(by: assistantId)

            // Checks
            XCTAssertEqual(assistant.id, assistantId)
            XCTAssertEqual(assistant.objectType, "assistant")
            XCTAssertEqual(assistant.createdAt, 1699009709)
            XCTAssertEqual(assistant.name, "HR Helper")
            XCTAssertEqual(assistant.model, "gpt-4")
            XCTAssertEqual(assistant.instructions, "You are an HR bot, and you have access to files to answer employee questions about company policies.")
            XCTAssertEqual(assistant.tools.count, 1)
            XCTAssertEqual(assistant.tools.first?.type, "retrieval")
            XCTAssertEqual(assistant.fileIds, ["file-abc123"])
            XCTAssertTrue(assistant.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testModifyAssistant() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.modify.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let assistantId = "asst_abc123"
            let modifyRequest = ASAModifyAssistantRequest(
                instructions: "You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.",
                fileIds: ["file-abc123", "file-abc456"]
            )

            let modifiedAssistant: ASAAssistant = try await assistantsAPI.modify(by: assistantId, 
                                                                                 modifyAssistant: modifyRequest)

            // Checks
            XCTAssertEqual(modifiedAssistant.id, assistantId)
            XCTAssertEqual(modifiedAssistant.objectType, "assistant")
            XCTAssertEqual(modifiedAssistant.createdAt, 1699009709)
            XCTAssertEqual(modifiedAssistant.name, "HR Helper")
            XCTAssertEqual(modifiedAssistant.model, "gpt-4")
            XCTAssertEqual(modifiedAssistant.instructions, modifyRequest.instructions)
            XCTAssertEqual(modifiedAssistant.tools.count, 1)
            XCTAssertEqual(modifiedAssistant.tools.first?.type, "retrieval")
            XCTAssertEqual(modifiedAssistant.fileIds, modifyRequest.fileIds)
            XCTAssertTrue(modifiedAssistant.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testDeleteAssistant() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.delete.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let assistantId = "asst_abc123"
            let deleteResponse: ASADeleteModelResponse = try await assistantsAPI.delete(by: assistantId)

            // Checks
            XCTAssertEqual(deleteResponse.id, assistantId)
            XCTAssertEqual(deleteResponse.object, "assistant.deleted")
            XCTAssertTrue(deleteResponse.deleted)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testCreateFile() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.createFile.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let createRequest = ASACreateAssistantFileRequest(fileId: "file-abc123")
            let file: ASAAssistantFile = try await assistantsAPI.createFile(for: "asst_abc123", with: createRequest)

            // Checks
            XCTAssertEqual(file.id, "file-abc123")
            XCTAssertEqual(file.objectType, "assistant.file")
            XCTAssertEqual(file.createdAt, 1699055364)
            XCTAssertEqual(file.assistantId, "asst_abc123")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testRetrieveFile() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.retrieveFile.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let file: ASAAssistantFile = try await assistantsAPI.retrieveFile(for: "asst_abc123", fileId: "file-abc123")

            // Checks
            XCTAssertEqual(file.id, "file-abc123")
            XCTAssertEqual(file.objectType, "assistant.file")
            XCTAssertEqual(file.createdAt, 1699055364)
            XCTAssertEqual(file.assistantId, "asst_abc123")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testDeleteFile() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.deleteFile.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let deleteResponse: ASADeleteModelResponse = try await assistantsAPI.deleteFile(for: "asst_abc123", fileId: "file-abc123")

            // Checks
            XCTAssertEqual(deleteResponse.id, "file-abc123")
            XCTAssertEqual(deleteResponse.object, "assistant.file.deleted")
            XCTAssertTrue(deleteResponse.deleted)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testListFiles() async {
        do {
            // Simulate server response
            let mockData = AssistantsAPITests.listFiles.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let listParameters = ASAListAssistantsParameters()
            let fileList: ASAAssistantFilesListResponse = try await assistantsAPI.listFiles(for: "asst_abc123", with: listParameters)

            // Checks
            XCTAssertEqual(fileList.object, "list")
            XCTAssertEqual(fileList.data.count, 2)
            XCTAssertEqual(fileList.firstId, "file-abc123")
            XCTAssertEqual(fileList.lastId, "file-abc456")
            XCTAssertFalse(fileList.hasMore)
            XCTAssertEqual(fileList.data[0].id, "file-abc123")
            XCTAssertEqual(fileList.data[1].id, "file-abc456")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
}
