# AISwiftAssist

A Swift Package Manager (SPM) library for iOS 13 and above, designed to simplify the integration with OpenAI's Assistants API in iOS applications. This library allows you to build AI-powered assistants efficiently and interactively.

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/zelentsov)

## Features

- Seamless integration with OpenAI's Assistants API.
- Easily create and manage AI assistants with various models and tools.
- Handle conversations through threads and messages.
- Utilize Code Interpreter, Retrieval, and Function calling tools.
- Optimized for iOS 13+ with Swift.

## Installation

### Using Xcode

To add `AISwiftAssist` to your Xcode project, follow these steps:

1. Open your project in Xcode.
2. Click on "File" in the menu bar, then select "Swift Packages" and then "Add Package Dependency..."
3. In the dialog that appears, enter the package repository URL: `https://github.com/DeveloperZelentsov/AiSwiftAssist.git`.
4. Choose the last version to integrate and click "Next".
5. Confirm the package products and targets and click "Finish".

## Usage

### Step 1: Import the Library

Import `AISwiftAssist` into your Swift file where you wish to use it:

```swift
import AISwiftAssist
```

### Step 2: Initialize the Client

Create an instance of AISwiftAssistClient using your API key and organization ID:

```swift
let config = AISwiftAssistConfig(apiKey: "your-api-key", organizationId: "your-org-id")
let aiSwiftAssistClient = AISwiftAssistClient(config: config)
```

### Step 3: Create an Assistant

To create an AI assistant, define its parameters such as model, name, description, and instructions. You can also specify tools and file IDs if required:

```swift
let assistantParams = AssistantCreationParams(
    modelName: "gpt-4-1106-preview",
    name: "Math Tutor",
    description: "Your personal math tutor.",
    instructions: "Solve math problems and explain solutions."
)

let creationAssistantParams = try await aiSwiftAssistClient.createAssistantAndThread(with: assistantParams)
let assistantId = creationParams.assistant.id
let threadId = creationParams.thread.id
```

### Step 4: Manage Conversations

Sending Messages

Send a message to your assistant through a created thread:

```swift
let messageRequest: ASACreateMessageRequest = .init(role: "user", content: content)
try await aiSwiftAssistClient.messagesApi.create(by: threadId, createMessage: messageRequest)
```

Initiating a Run

To process the message and receive a response, initiate a run:

```swift
let runRequest = ASACreateRunRequest(assistantId: assistantId)
try await aiSwiftAssistClient.runsApi.create(by: threadId, createRun: runRequest)
```

Fetching Responses

Retrieve the assistant's response:

```swift
let messages = try await aiSwiftAssistClient.messagesApi.list(threadId: threadId)
// Process and display these messages, including the assistant's response.
```

### Step 5: Continuous Interaction

Continue the conversation by sending additional messages, initiating runs, and fetching responses. This creates a dynamic and interactive communication flow with the assistant.

## Beyond the Basics

This is an example of the most basic usage of the Assistants API. There is potential for much more complex and interesting assistants, and I will continue to evolve this Swift API to enable you to leverage these advanced capabilities.

## Feedback and Contributions

We welcome your feedback and contributions to enhance `AISwiftAssist`. Please feel free to report issues or submit pull requests on our GitHub repository.

## License

This library is distributed under the MIT License.
