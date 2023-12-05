//
//  File.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import Foundation

extension MessagesAPITests {
    
    static let list: String =
    """
    {
      "object": "list",
      "data": [
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1699016383,
          "thread_id": "thread_abc123",
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "assistant_id": null,
          "run_id": null,
          "metadata": {}
        },
        {
          "id": "msg_abc456",
          "object": "thread.message",
          "created_at": 1699016383,
          "thread_id": "thread_abc123",
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "Hello, what is AI?",
                "annotations": []
              }
            }
          ],
          "file_ids": [
            "file-abc123"
          ],
          "assistant_id": null,
          "run_id": null,
          "metadata": {}
        }
      ],
      "first_id": "msg_abc123",
      "last_id": "msg_abc456",
      "has_more": false
    }
    """

    static let modify: String =
    """
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1699017614,
          "thread_id": "thread_abc123",
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "assistant_id": null,
          "run_id": null,
          "metadata": {
            "modified": "true",
            "user": "abc123"
          }
        }
        """

    static let retrieve: String =
    """
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1699017614,
          "thread_id": "thread_abc123",
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "assistant_id": null,
          "run_id": null,
          "metadata": {}
        }
        """

    static let create: String =
                """
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1699017614,
          "thread_id": "thread_abc123",
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "assistant_id": null,
          "run_id": null,
          "metadata": {}
        }
        """

    static let retrieveFile: String =
        """
        {
          "id": "file-abc123",
          "object": "thread.message.file",
          "created_at": 1698107661,
          "message_id": "message_QLoItBbqwyAJEzlTy4y9kOMM",
          "file_id": "file-abc123"
        }
        """
    
    static let listFiles: String =
        """
        {
          "object": "list",
          "data": [
            {
              "id": "file-abc123",
              "object": "thread.message.file",
              "created_at": 1698107661,
              "message_id": "message_QLoItBbqwyAJEzlTy4y9kOMM"
            },
            {
              "id": "file-abc456",
              "object": "thread.message.file",
              "created_at": 1698107662,
              "message_id": "message_QLoItBbqwyAJEzlTy4y9kONN"
            }
          ],
          "first_id": "file-abc123",
          "last_id": "file-abc456",
          "has_more": false
        }
        """
}
