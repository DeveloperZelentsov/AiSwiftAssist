//
//  AISwiftAssistConfig 2.swift
//  AISwiftAssist
//
//  Created by Alexey on 3/6/25.
//

public struct AISwiftAssistConstants: Sendable {

    public enum AssistantsVersion: String, Sendable {
        case v1 = "assistants=v1" /// deprecated
        case v2 = "assistants=v2"
    }

    public let baseScheme: String
    public let baseHost: String
    public let path: String
    /// The version of the Assistants API to use.
    public let version: AssistantsVersion

    public init(
        baseScheme: String = "https",
        baseHost: String = "api.openai.com",
        path: String = "/v1/",
        version: AssistantsVersion = .v2
    ) {
        self.baseScheme = baseScheme
        self.baseHost = baseHost
        self.path = path
        self.version = version
    }

    public static let `default`: AISwiftAssistConstants = .init()
}
