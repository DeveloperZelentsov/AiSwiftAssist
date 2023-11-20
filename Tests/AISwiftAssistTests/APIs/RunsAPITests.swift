//
//  RunsAPITests.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import XCTest
@testable import AISwiftAssist

final class RunsAPITests: XCTestCase {

    var runsAPI: IRunsAPI!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        runsAPI = RunsAPI(urlSession: mockURLSession)
    }

    override func tearDown() {
        runsAPI = nil
        super.tearDown()
    }

    func testCreateRun() async {
        do {
            let mockData = Self.create.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let createRunRequest = ASACreateRunRequest(assistantId: "asst_abc123")
            let run: ASARun = try await runsAPI.create(by: "thread_abc123", 
                                                       createRun: createRunRequest)

            XCTAssertEqual(run.id, "run_abc123")
            XCTAssertEqual(run.object, "thread.run")
            XCTAssertEqual(run.createdAt, 1699063290)
            XCTAssertEqual(run.assistantId, "asst_abc123")
            XCTAssertEqual(run.threadId, "thread_abc123")
            XCTAssertEqual(run.status, "queued")
            XCTAssertEqual(run.startedAt, 1699063290)
            XCTAssertNil(run.expiresAt)
            XCTAssertNil(run.cancelledAt)
            XCTAssertNil(run.failedAt)
            XCTAssertEqual(run.completedAt, 1699063291)
            XCTAssertNil(run.lastError)
            XCTAssertEqual(run.model, "gpt-4")
            XCTAssertNil(run.instructions)
            XCTAssertEqual(run.tools.count, 1)
            XCTAssertEqual(run.tools.first?.type, "code_interpreter")
            XCTAssertEqual(run.fileIds, ["file-abc123", "file-abc456"])
            XCTAssertTrue(run.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
    
    func testRetrieveRun() async {
        do {
            let mockData = Self.retrieve.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let run: ASARun = try await runsAPI.retrieve(by: "thread_abc123", 
                                                         runId: "run_abc123")

            XCTAssertEqual(run.id, "run_abc123")
            XCTAssertEqual(run.object, "thread.run")
            XCTAssertEqual(run.createdAt, 1699075072)
            XCTAssertEqual(run.assistantId, "asst_abc123")
            XCTAssertEqual(run.threadId, "thread_abc123")
            XCTAssertEqual(run.status, "completed")
            XCTAssertEqual(run.startedAt, 1699075072)
            XCTAssertNil(run.expiresAt)
            XCTAssertNil(run.cancelledAt)
            XCTAssertNil(run.failedAt)
            XCTAssertEqual(run.completedAt, 1699075073)
            XCTAssertNil(run.lastError)
            XCTAssertEqual(run.model, "gpt-3.5-turbo")
            XCTAssertNil(run.instructions)
            XCTAssertEqual(run.tools.count, 1)
            XCTAssertEqual(run.tools.first?.type, "code_interpreter")
            XCTAssertEqual(run.fileIds, ["file-abc123", "file-abc456"])
            XCTAssertTrue(run.metadata?.isEmpty ?? true)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testModifyRun() async {
        do {
            let mockData = Self.modify.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let modifyRunRequest = ASAModifyRunRequest(metadata: ["user_id": "user_abc123"])
            let run: ASARun = try await runsAPI.modify(by: "thread_abc123", 
                                                       runId: "run_abc123",
                                                       modifyRun: modifyRunRequest)

            XCTAssertEqual(run.id, "run_abc123")
            XCTAssertEqual(run.object, "thread.run")
            XCTAssertEqual(run.createdAt, 1699075072)
            XCTAssertEqual(run.assistantId, "asst_abc123")
            XCTAssertEqual(run.threadId, "thread_abc123")
            XCTAssertEqual(run.status, "completed")
            XCTAssertEqual(run.startedAt, 1699075072)
            XCTAssertNil(run.expiresAt)
            XCTAssertNil(run.cancelledAt)
            XCTAssertNil(run.failedAt)
            XCTAssertEqual(run.completedAt, 1699075073)
            XCTAssertNil(run.lastError)
            XCTAssertEqual(run.model, "gpt-3.5-turbo")
            XCTAssertNil(run.instructions)
            XCTAssertEqual(run.tools.count, 1)
            XCTAssertEqual(run.tools.first?.type, "code_interpreter")
            XCTAssertEqual(run.fileIds, ["file-abc123", "file-abc456"])
            XCTAssertEqual(run.metadata?["user_id"], "user_abc123")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testListRuns() async {
        do {
            let mockData = Self.list.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let listResponse: ASARunsListResponse = try await runsAPI.listRuns(by: "thread_abc123", 
                                                                               parameters: nil)

            XCTAssertEqual(listResponse.object, "list")
            XCTAssertEqual(listResponse.data.count, 2)

            let firstRun = listResponse.data[0]
            XCTAssertEqual(firstRun.id, "run_abc123")
            XCTAssertEqual(firstRun.object, "thread.run")
            XCTAssertEqual(firstRun.createdAt, 1699075072)
            XCTAssertEqual(firstRun.assistantId, "asst_abc123")
            XCTAssertEqual(firstRun.threadId, "thread_abc123")
            XCTAssertEqual(firstRun.status, "completed")
            XCTAssertEqual(firstRun.startedAt, 1699075072)
            XCTAssertNil(firstRun.expiresAt)
            XCTAssertNil(firstRun.cancelledAt)
            XCTAssertNil(firstRun.failedAt)
            XCTAssertEqual(firstRun.completedAt, 1699075073)
            XCTAssertNil(firstRun.lastError)
            XCTAssertEqual(firstRun.model, "gpt-3.5-turbo")
            XCTAssertNil(firstRun.instructions)
            XCTAssertEqual(firstRun.tools.count, 1)
            XCTAssertEqual(firstRun.tools[0].type, "code_interpreter")
            XCTAssertEqual(firstRun.fileIds, ["file-abc123", "file-abc456"])
            XCTAssertTrue(firstRun.metadata?.isEmpty ?? true)

            XCTAssertEqual(listResponse.firstId, "run_abc123")
            XCTAssertEqual(listResponse.lastId, "run_abc456")
            XCTAssertFalse(listResponse.hasMore)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

}
