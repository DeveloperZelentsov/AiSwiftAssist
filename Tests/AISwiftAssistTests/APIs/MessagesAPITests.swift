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

            let createMessageRequest = ASACreateMessageRequest(role: "user", content: "How does AI work? Explain it in simple terms.")
            let message: ASAMessage = try await messagesAPI.create(by: "thread123", createMessage: createMessageRequest)

            XCTAssertEqual(message.id, "12345")
            XCTAssertEqual(message.object, "thread.message")
            XCTAssertEqual(message.createdAt, 1639530000)
            XCTAssertEqual(message.threadId, "thread123")
            XCTAssertEqual(message.role, "assistant")
            XCTAssertEqual(message.content.count, 2)

            if let firstContent = message.content.first {
                switch firstContent {
                case .text(let textContent):
                    XCTAssertEqual(textContent.value, "This is a text message with annotations.")
                    XCTAssertEqual(textContent.annotations?.count, 2)
                default:
                    XCTFail("First content is not of type text.")
                }
            } else {
                XCTFail("First content is empty")
            }

            if message.content.count > 1 {
                switch message.content[1] {
                case .image(let imageContent):
                    XCTAssertEqual(imageContent.file_id, "image789")
                default:
                    XCTFail("Second content is not of type image.")
                }
            } else {
                XCTFail("Second content is missing.")
            }

            XCTAssertEqual(message.assistantId, "assistant123")
            XCTAssertEqual(message.runId, "run123")
            XCTAssertEqual(message.fileIds, ["file123", "file456", "image789"])
            XCTAssertEqual(message.metadata?["key1"], "value1")
            XCTAssertEqual(message.metadata?["key2"], "value2")
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

            let message: ASAMessage = try await messagesAPI.retrieve(by: "thread123", messageId: "12345")

            XCTAssertEqual(message.id, "12345")
            XCTAssertEqual(message.object, "thread.message")
            XCTAssertEqual(message.createdAt, 1639530000)
            XCTAssertEqual(message.threadId, "thread123")
            XCTAssertEqual(message.role, "assistant")
            XCTAssertEqual(message.content.count, 2)

            if let firstContent = message.content.first {
                switch firstContent {
                case .text(let textContent):
                    XCTAssertEqual(textContent.value, "This is a text message with annotations.")
                    XCTAssertEqual(textContent.annotations?.count, 2)

                    if let firstAnnotation = textContent.annotations?.first {
                        XCTAssertEqual(firstAnnotation.type, "file_citation")
                        XCTAssertEqual(firstAnnotation.text, "document link")
                        XCTAssertEqual(firstAnnotation.startIndex, 0)
                        XCTAssertEqual(firstAnnotation.endIndex, 23)
                        XCTAssertEqual(firstAnnotation.fileCitation?.fileId, "file123")
                        XCTAssertEqual(firstAnnotation.fileCitation?.quote, "A quote from the file")
                    } else {
                        XCTFail("First annotation not found.")
                    }
                default:
                    XCTFail("First content is not of type text.")
                }
            } else {
                XCTFail("Content is empty")
            }

            if let secondContent = message.content.last {
                switch secondContent {
                case .image(let imageContent):
                    XCTAssertEqual(imageContent.file_id, "image789")
                default:
                    XCTFail("Second content is not of type image.")
                }
            } else {
                XCTFail("Second content is missing.")
            }

            XCTAssertEqual(message.assistantId, "assistant123")
            XCTAssertEqual(message.runId, "run123")
            XCTAssertEqual(message.fileIds, ["file123", "file456", "image789"])
            XCTAssertEqual(message.metadata?["key1"], "value1")
            XCTAssertEqual(message.metadata?["key2"], "value2")
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
            let message: ASAMessage = try await messagesAPI.modify(by: "thread123",
                                                                   messageId: "12345",
                                                                   modifyMessage: modifyMessageRequest)

            XCTAssertEqual(message.id, "12345")
            XCTAssertEqual(message.object, "thread.message")
            XCTAssertEqual(message.createdAt, 1639530000)
            XCTAssertEqual(message.threadId, "thread123")
            XCTAssertEqual(message.role, "assistant")

            if let firstContent = message.content.first {
                switch firstContent {
                case .text(let textContent):
                    XCTAssertEqual(textContent.value, "This is a text message with annotations.")
                    XCTAssertEqual(textContent.annotations?.count, 2)
                default:
                    XCTFail("First content is not of type text.")
                }
            } else {
                XCTFail("Content is empty")
            }

            if message.content.count > 1 {
                switch message.content[1] {
                case .image(let imageContent):
                    XCTAssertEqual(imageContent.file_id, "image789")
                default:
                    XCTFail("Second content is not of type image.")
                }
            } else {
                XCTFail("Second content is missing.")
            }

            XCTAssertEqual(message.assistantId, "assistant123")
            XCTAssertEqual(message.runId, "run123")
            XCTAssertEqual(message.fileIds, ["file123", "file456", "image789"])
            XCTAssertEqual(message.metadata?["key1"], "value1")
            XCTAssertEqual(message.metadata?["key2"], "value2")
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

            let listResponse: ASAMessagesListResponse = try await messagesAPI.getMessages(by: "thread_abc123", parameters: nil)

            XCTAssertEqual(listResponse.object, "list")
            XCTAssertEqual(listResponse.data.count, 3)
            XCTAssertEqual(listResponse.data[0].id, "msg_SM7CyvQn3UnrAyOh96TGN5jR")
            XCTAssertEqual(listResponse.data[0].threadId, "thread_11LlFPiPpEw7WhZr0AqB2WhF")
            XCTAssertEqual(listResponse.data[0].role, "assistant")

            // Тестирование содержимого первого сообщения
            if let firstContent = listResponse.data[0].content.first {
                switch firstContent {
                case .text(let textContent):
                    XCTAssertEqual(textContent.value, "I now have full annotations for every date mentioned in the file")
                    XCTAssertEqual(textContent.annotations?.count, 4)

                    if let firstAnnotation = textContent.annotations?.first {
                        XCTAssertEqual(firstAnnotation.type, "file_citation")
                        XCTAssertEqual(firstAnnotation.text, "【21†source】")
                        XCTAssertEqual(firstAnnotation.startIndex, 136)
                        XCTAssertEqual(firstAnnotation.endIndex, 147)
                        XCTAssertEqual(firstAnnotation.fileCitation?.fileId, "")
                        XCTAssertEqual(firstAnnotation.fileCitation?.quote, "adfadlfkjamdf")
                    } else {
                        XCTFail("First annotation not found.")
                    }

                    if let firstAnnotation = textContent.annotations?.last {
                        XCTAssertEqual(firstAnnotation.type, "file_citation")
                        XCTAssertEqual(firstAnnotation.text, "【33†source】")
                        XCTAssertEqual(firstAnnotation.startIndex, 378)
                        XCTAssertEqual(firstAnnotation.endIndex, 389)
                        XCTAssertEqual(firstAnnotation.fileCitation?.fileId, "")
                        XCTAssertEqual(firstAnnotation.fileCitation?.quote, "DXB")
                    } else {
                        XCTFail("First annotation not found.")
                    }
                default:
                    XCTFail("First content is not of type text.")
                }
            } else {
                XCTFail("Content is empty")
            }

            XCTAssertEqual(listResponse.data[1].id, "msg_oacFAKp8WbIKYnV2Wmsyh5aE")
            XCTAssertEqual(listResponse.data[1].threadId, "thread_11LlFPiPpEw7WhZr0AqB2WhF")
            XCTAssertEqual(listResponse.data[1].role, "assistant")

            XCTAssertEqual(listResponse.data[2].id, "msg_V8hf7PCvWceW4DpQKpQV83Ia")
            XCTAssertEqual(listResponse.data[2].threadId, "thread_11LlFPiPpEw7WhZr0AqB2WhF")
            XCTAssertEqual(listResponse.data[2].role, "user")
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
