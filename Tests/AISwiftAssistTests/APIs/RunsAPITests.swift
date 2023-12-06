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

    func testSubmitToolOutputs() async {
        do {
            let mockData = RunsAPITests.submitToolOutputs.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                XCTAssertEqual(request.url?.path, "/v1/threads/thread_abc123/runs/run_abc123/submit_tool_outputs")
                XCTAssertEqual(request.httpMethod, "POST")
                // Проверка тела запроса может быть добавлена здесь
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let toolOutputs = [ASAToolOutput(toolCallId: "call_abc123", output: "28C")]
            let run: ASARun = try await runsAPI.submitToolOutputs(by: "thread_abc123", runId: "run_abc123", toolOutputs: toolOutputs)

            XCTAssertEqual(run.id, "run_abc123")
            XCTAssertEqual(run.object, "thread.run")
            XCTAssertEqual(run.createdAt, 1699063291)
            XCTAssertEqual(run.threadId, "thread_abc123")
            XCTAssertEqual(run.assistantId, "asst_abc123")
            XCTAssertEqual(run.status, "completed")
            XCTAssertEqual(run.startedAt, 1699063292)
            XCTAssertEqual(run.expiresAt, 1699066891)
            XCTAssertNil(run.cancelledAt)
            XCTAssertNil(run.failedAt)
            XCTAssertEqual(run.completedAt, 1699063391)
            XCTAssertNil(run.lastError)
            XCTAssertEqual(run.model, "gpt-3.5-turbo")
            XCTAssertEqual(run.instructions, "You are a helpful assistant.")
            XCTAssertEqual(run.tools.count, 1)
            XCTAssertEqual(run.tools.first?.type, "function")
            XCTAssertEqual(run.fileIds, ["file-abc123"])
            XCTAssertEqual(run.metadata?["additional_info"], "test")
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
    
    func testCancelRun() async {
        do {

            let mockData = RunsAPITests.cancelRun.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                XCTAssertEqual(request.url?.path, "/v1/threads/thread_abc123/runs/run_abc123/cancel")
                XCTAssertEqual(request.httpMethod, "POST")
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let run: ASARun = try await runsAPI.cancelRun(by: "thread_abc123", runId: "run_abc123")

            XCTAssertEqual(run.id, "run_abc123")
            XCTAssertEqual(run.object, "thread.run")
            XCTAssertEqual(run.status, "cancelled")
            XCTAssertEqual(run.createdAt, 1699075072)
            XCTAssertEqual(run.assistantId, "asst_abc123")
            XCTAssertEqual(run.threadId, "thread_abc123")
            XCTAssertEqual(run.status, "cancelled")
            XCTAssertEqual(run.startedAt, 1699075072)
            XCTAssertEqual(run.expiresAt, 1699075672)
            XCTAssertEqual(run.cancelledAt, 1699075092)
            XCTAssertNil(run.failedAt)
            XCTAssertNil(run.completedAt)
            XCTAssertNil(run.lastError)
            XCTAssertEqual(run.model, "gpt-3.5-turbo")
            XCTAssertEqual(run.instructions, "Provide instructions")
            XCTAssertTrue(run.tools.isEmpty)
            XCTAssertEqual(run.fileIds, ["file-abc123"])
            XCTAssertEqual(run.metadata?["key"], "value")
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }

    func testCreateThreadAndRun() async {
        do {
            let mockData = RunsAPITests.createThreadAndRun.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                XCTAssertEqual(request.url?.path, "/v1/threads/runs")
                XCTAssertEqual(request.httpMethod, "POST")
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let createThreadRunRequest = ASACreateThreadRunRequest(assistantId: "", thread: ASACreateThreadRunRequest.Thread(messages: []))
            let run: ASARun = try await runsAPI.createThreadAndRun(createThreadRun: createThreadRunRequest)

            XCTAssertEqual(run.id, "run_xyz123")
            XCTAssertEqual(run.object, "thread.run")
            XCTAssertEqual(run.createdAt, 1699080000)
            XCTAssertEqual(run.threadId, "thread_xyz123")
            XCTAssertEqual(run.assistantId, "asst_xyz123")
            XCTAssertEqual(run.status, "in_progress")
            XCTAssertEqual(run.startedAt, 1699080001)
            XCTAssertEqual(run.expiresAt, 1699080600)
            XCTAssertNil(run.cancelledAt)
            XCTAssertNil(run.failedAt)
            XCTAssertNil(run.completedAt)
            XCTAssertNil(run.lastError)
            XCTAssertEqual(run.model, "gpt-3.5-turbo")
            XCTAssertEqual(run.instructions, "Explain deep learning to a 5 year old.")
            XCTAssertEqual(run.tools.count, 1)
            XCTAssertEqual(run.fileIds, ["file-xyz123"])
            XCTAssertEqual(run.metadata?["session"], "1")
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }

    func testRetrieveRunStep() async {
        do {
            let mockData = RunsAPITests.retrieveRunStep.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                XCTAssertEqual(request.url?.path, "/v1/threads/thread_abc123/runs/run_abc123/steps/step_xyz123")
                XCTAssertEqual(request.httpMethod, "GET")
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let runStep: ASARunStep = try await runsAPI.retrieveRunStep(by: "thread_abc123", runId: "run_abc123", stepId: "step_xyz123")

            XCTAssertEqual(runStep.id, "step_abc123")
            XCTAssertEqual(runStep.object, "thread.run.step")
            XCTAssertEqual(runStep.createdAt, 1699063291)
            XCTAssertEqual(runStep.runId, "run_abc123")
            XCTAssertEqual(runStep.assistantId, "asst_abc123")
            XCTAssertEqual(runStep.threadId, "thread_abc123")
            XCTAssertEqual(runStep.type, "message_creation")
            XCTAssertEqual(runStep.status, "completed")
            XCTAssertNil(runStep.cancelledAt)
            XCTAssertEqual(runStep.completedAt, 1699063291)
            XCTAssertNil(runStep.expiredAt)
            XCTAssertNil(runStep.failedAt)
            XCTAssertNil(runStep.lastError)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }

    func testListRunSteps() async {
        do {
            let mockData = RunsAPITests.listRunSteps.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                XCTAssertEqual(request.url?.path, "/v1/threads/thread_abc123/runs/run_abc123/steps")
                XCTAssertEqual(request.httpMethod, "GET")
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let listResponse: ASARunStepsListResponse = try await runsAPI.listRunSteps(by: "thread_abc123", runId: "run_abc123", parameters: nil)

            XCTAssertEqual(listResponse.object, "list")
            XCTAssertEqual(listResponse.data.count, 1)

            let firstStep = listResponse.data[0]
            XCTAssertEqual(firstStep.id, "step_xyz123")
            XCTAssertEqual(firstStep.object, "thread.run.step")
            XCTAssertEqual(firstStep.createdAt, 1699080100)
            XCTAssertEqual(firstStep.runId, "run_xyz123")
            XCTAssertEqual(firstStep.assistantId, "asst_xyz123")
            XCTAssertEqual(firstStep.threadId, "thread_xyz123")
            XCTAssertEqual(firstStep.type, "message_creation")
            XCTAssertEqual(firstStep.status, "completed")
            XCTAssertNil(firstStep.cancelledAt)
            XCTAssertEqual(firstStep.completedAt, 1699080200)
            XCTAssertNil(firstStep.expiredAt)
            XCTAssertNil(firstStep.failedAt)
            XCTAssertNil(firstStep.lastError)

        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }


}
