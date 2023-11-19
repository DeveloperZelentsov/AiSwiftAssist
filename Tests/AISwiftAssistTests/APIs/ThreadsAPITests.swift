//
//  ThreadsAPITests.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import XCTest
@testable import AISwiftAssist

final class ThreadsAPITests: XCTestCase {

    var threadsAPI: IThreadsAPI!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        threadsAPI = ThreadsAPI(urlSession: mockURLSession)
    }

    override func tearDown() {
        threadsAPI = nil
        super.tearDown()
    }

    func testCreateThread() async {
        do {
            // Simulate server response
            let mockData = Self.create.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let message = ASACreateThreadRequest.Message(role: "user",
                                                         content: "Hello World", 
                                                         fileIds: nil,
                                                         metadata: nil)
            let createRequest = ASACreateThreadRequest(messages: [message])
            let thread: ASAThread = try await threadsAPI.create(by: createRequest)

            // Checks
            XCTAssertEqual(thread.id, "thread_abc123")
            XCTAssertEqual(thread.object, "thread")
            XCTAssertEqual(thread.createdAt, 1699012949)
            XCTAssertTrue(thread.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testRetrieveThread() async {
        do {
            // Simulate server response
            let mockData = Self.retrieve.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let threadId = "thread_abc123"
            let thread: ASAThread = try await threadsAPI.retrieve(threadId: threadId)

            // Checks
            XCTAssertEqual(thread.id, threadId)
            XCTAssertEqual(thread.object, "thread")
            XCTAssertEqual(thread.createdAt, 1699014083)
            XCTAssertTrue(thread.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testModifyThread() async {
        do {
            // Simulate server response
            let mockData = Self.modify.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let threadId = "thread_abc123"
            let modifyRequest = ASAModifyThreadRequest(metadata: ["modified": "true", 
                                                                  "user": "abc123"])

            let modifiedThread: ASAThread = try await threadsAPI.modify(threadId: threadId, 
                                                                        with: modifyRequest)

            // Checks
            XCTAssertEqual(modifiedThread.id, threadId)
            XCTAssertEqual(modifiedThread.object, "thread")
            XCTAssertEqual(modifiedThread.createdAt, 1699014083)
            XCTAssertEqual(modifiedThread.metadata?["modified"], "true")
            XCTAssertEqual(modifiedThread.metadata?["user"], "abc123")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testDeleteThread() async {
        do {
            // Simulate server response
            let mockData = Self.delete.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let threadId = "thread_abc123"
            let deleteResponse: ASADeleteModelResponse = try await threadsAPI.delete(threadId: threadId)

            // Checks
            XCTAssertEqual(deleteResponse.id, threadId)
            XCTAssertEqual(deleteResponse.object, "thread.deleted")
            XCTAssertTrue(deleteResponse.deleted)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

}
