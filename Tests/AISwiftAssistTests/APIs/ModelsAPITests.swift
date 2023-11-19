//
//  ModelsAPITests.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import XCTest
@testable import AISwiftAssist

final class ModelsAPITests: XCTestCase {

    var modelsAPI: IModelsAPI!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        modelsAPI = ModelsAPI(urlSession: mockURLSession)
    }

    override func tearDown() {
        modelsAPI = nil
        super.tearDown()
    }

    func testListModels() async {
        do {
            // Simulate server response
            let mockData = Self.list.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let listResponse: ASAListModelsResponse = try await modelsAPI.get()

            XCTAssertEqual(listResponse.data[0].id, "model-id-0")
            XCTAssertEqual(listResponse.data[0].object, "model")
            XCTAssertEqual(listResponse.data[0].created, 1686935002)
            XCTAssertEqual(listResponse.data[0].ownedBy, "organization-owner")

            XCTAssertEqual(listResponse.data[1].id, "model-id-1")
            XCTAssertEqual(listResponse.data[1].object, "model")
            XCTAssertEqual(listResponse.data[1].created, 1686935002)
            XCTAssertEqual(listResponse.data[1].ownedBy, "organization-owner")

            XCTAssertEqual(listResponse.data[2].id, "model-id-2")
            XCTAssertEqual(listResponse.data[2].object, "model")
            XCTAssertEqual(listResponse.data[2].created, 1686935002)
            XCTAssertEqual(listResponse.data[2].ownedBy, "openai")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testRetrieveModel() async {
        do {
            // Simulate server response
            let mockData = Self.retrieve.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let modelId = "gpt-3.5-turbo-instruct"
            let model: ASAModel = try await modelsAPI.retrieve(by: modelId)

            XCTAssertEqual(model.id, modelId)
            XCTAssertEqual(model.object, "model")
            XCTAssertEqual(model.created, 1686935002)
            XCTAssertEqual(model.ownedBy, "openai")
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testDeleteModel() async {
        do {
            // Simulate server response
            let mockData = Self.delete.data(using: .utf8)!

            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, mockData)
            }

            let modelId = "ft:gpt-3.5-turbo:acemeco:suffix:abc123"
            let deleteResponse: ASADeleteModelResponse = try await modelsAPI.delete(by: modelId)

            XCTAssertEqual(deleteResponse.id, "ft:gpt-3.5-turbo:acemeco:suffix:abc123")
            XCTAssertEqual(deleteResponse.object, "model")
            XCTAssertTrue(deleteResponse.deleted)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

}
