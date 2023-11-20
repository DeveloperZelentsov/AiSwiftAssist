//
//  File.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import Foundation

extension RunsAPITests {
    static let create: String =
                """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699063290,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "queued",
          "started_at": 1699063290,
          "expires_at": null,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": 1699063291,
          "last_error": null,
          "model": "gpt-4",
          "instructions": null,
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "file_ids": [
            "file-abc123",
            "file-abc456"
          ],
          "metadata": {}
        }
        """
    
    static let retrieve: String =
                """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699075072,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "completed",
          "started_at": 1699075072,
          "expires_at": null,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": 1699075073,
          "last_error": null,
          "model": "gpt-3.5-turbo",
          "instructions": null,
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "file_ids": [
            "file-abc123",
            "file-abc456"
          ],
          "metadata": {}
        }
        """

    static let modify: String =
                """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699075072,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "completed",
          "started_at": 1699075072,
          "expires_at": null,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": 1699075073,
          "last_error": null,
          "model": "gpt-3.5-turbo",
          "instructions": null,
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "file_ids": [
            "file-abc123",
            "file-abc456"
          ],
          "metadata": {
            "user_id": "user_abc123"
          }
        }
        """

    static let list: String =
    """
{
  "object": "list",
  "data": [
    {
      "id": "run_abc123",
      "object": "thread.run",
      "created_at": 1699075072,
      "assistant_id": "asst_abc123",
      "thread_id": "thread_abc123",
      "status": "completed",
      "started_at": 1699075072,
      "expires_at": null,
      "cancelled_at": null,
      "failed_at": null,
      "completed_at": 1699075073,
      "last_error": null,
      "model": "gpt-3.5-turbo",
      "instructions": null,
      "tools": [
        {
          "type": "code_interpreter"
        }
      ],
      "file_ids": [
        "file-abc123",
        "file-abc456"
      ],
      "metadata": {}
    },
    {
      "id": "run_abc456",
      "object": "thread.run",
      "created_at": 1699063290,
      "assistant_id": "asst_abc123",
      "thread_id": "thread_abc123",
      "status": "completed",
      "started_at": 1699063290,
      "expires_at": null,
      "cancelled_at": null,
      "failed_at": null,
      "completed_at": 1699063291,
      "last_error": null,
      "model": "gpt-3.5-turbo",
      "instructions": null,
      "tools": [
        {
          "type": "code_interpreter"
        }
      ],
      "file_ids": [
        "file-abc123",
        "file-abc456"
      ],
      "metadata": {}
    }
  ],
  "first_id": "run_abc123",
  "last_id": "run_abc456",
  "has_more": false
}
"""
}
