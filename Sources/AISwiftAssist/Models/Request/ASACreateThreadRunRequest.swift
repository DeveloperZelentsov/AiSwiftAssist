//
//  File.swift
//  
//
//  Created by Alexey on 12/5/23.
//

import Foundation

/// A request structure for creating a thread and run.
public struct ASACreateThreadRunRequest: Codable {
    /// The ID of the assistant to use to execute this run.
    public let assistantId: String

    /// The thread object containing messages and other parameters.
    public let thread: Thread

    /// Represents a thread containing messages and other parameters.
    public struct Thread: Codable {
        /// The messages to be processed in this thread.
        public let messages: [Message]

        /// Represents a single message in a thread.
        public struct Message: Codable {
            /// The role of the message sender, e.g., 'user' or 'system'.
            public let role: String

            /// The content of the message.
            public let content: String
        }
    }

    public init(assistantId: String, thread: Thread) {
        self.assistantId = assistantId
        self.thread = thread
    }
}
