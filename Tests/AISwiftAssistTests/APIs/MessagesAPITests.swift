//
//  MessagesAPITests.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import XCTest
@testable import AISwiftAssist

final class MessagesAPITests: XCTestCase {

    var messagesAPI: IMessagesAPI!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        messagesAPI = MessagesAPI(urlSession: mockURLSession)
    }

    override func tearDown() {
        messagesAPI = nil
        super.tearDown()
    }

    func testCreateMessage() async {
        do {
            let mockData = Self.create.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let createMessageRequest = ASACreateMessageRequest(role: "user", 
                                                               content: "How does AI work? Explain it in simple terms.")
            let message: ASAMessage = try await messagesAPI.create(by: "thread_abc123", 
                                                                   createMessage: createMessageRequest)

            XCTAssertEqual(message.id, "msg_abc123")
            XCTAssertEqual(message.object, "thread.message")
            XCTAssertEqual(message.createdAt, 1699017614)
            XCTAssertEqual(message.threadId, "thread_abc123")
            XCTAssertEqual(message.role, "user")
            XCTAssertEqual(message.content.first?.text?.value, "How does AI work? Explain it in simple terms.")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testRetrieveMessage() async {
        do {
            let mockData = Self.retrieve.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let message: ASAMessage = try await messagesAPI.retrieve(by: "thread_abc123", 
                                                                     messageId: "msg_abc123")

            XCTAssertEqual(message.id, "msg_abc123")
            XCTAssertEqual(message.object, "thread.message")
            XCTAssertEqual(message.createdAt, 1699017614)
            XCTAssertEqual(message.threadId, "thread_abc123")
            XCTAssertEqual(message.role, "user")
            XCTAssertEqual(message.content.first?.text?.value, "How does AI work? Explain it in simple terms.")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testModifyMessage() async {
        do {
            let mockData = Self.modify.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let modifyMessageRequest = ASAModifyMessageRequest(metadata: ["modified": "true", 
                                                                          "user": "abc123"])
            let message: ASAMessage = try await messagesAPI.modify(by: "thread_abc123", 
                                                                   messageId: "msg_abc123",
                                                                   modifyMessage: modifyMessageRequest)

            XCTAssertEqual(message.id, "msg_abc123")
            XCTAssertEqual(message.object, "thread.message")
            XCTAssertEqual(message.createdAt, 1699017614)
            XCTAssertEqual(message.threadId, "thread_abc123")
            XCTAssertEqual(message.role, "user")
            XCTAssertEqual(message.metadata?["modified"], "true")
            XCTAssertEqual(message.metadata?["user"], "abc123")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testListMessages() async {
        do {
            let mockData = Self.list.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let listResponse: ASAMessagesListResponse = try await messagesAPI.getMessages(by: "thread_abc123", 
                                                                                          parameters: nil)

            XCTAssertEqual(listResponse.object, "list")
            XCTAssertEqual(listResponse.data.count, 2)
            XCTAssertEqual(listResponse.data[0].id, "msg_abc123")
            XCTAssertEqual(listResponse.data[0].threadId, "thread_abc123")
            XCTAssertEqual(listResponse.data[0].role, "user")
            XCTAssertEqual(listResponse.data[0].content.first?.text?.value, "How does AI work? Explain it in simple terms.")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testRetrieveFile() async {
        do {
            let mockData = Self.retrieveFile.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let file: ASAMessageFile = try await messagesAPI.retrieveFile(by: "thread_abc123", messageId: "msg_abc123", fileId: "file-abc123")

            XCTAssertEqual(file.id, "file-abc123")
            XCTAssertEqual(file.object, "thread.message.file")
            XCTAssertEqual(file.createdAt, 1698107661)
            XCTAssertEqual(file.messageId, "message_QLoItBbqwyAJEzlTy4y9kOMM")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testListFiles() async {
        do {
            let mockData = Self.listFiles.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let listResponse: ASAMessageFilesListResponse = try await messagesAPI.listFiles(by: "thread_abc123", messageId: "msg_abc123", parameters: nil)

            XCTAssertEqual(listResponse.object, "list")
            XCTAssertEqual(listResponse.data.count, 2)
            XCTAssertEqual(listResponse.data[0].id, "file-abc123")
            XCTAssertEqual(listResponse.data[0].createdAt, 1698107661)
            XCTAssertEqual(listResponse.data[0].messageId, "message_QLoItBbqwyAJEzlTy4y9kOMM")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

}
