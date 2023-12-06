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
    static let submitToolOutputs: String =
        """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699063291,
          "thread_id": "thread_abc123",
          "assistant_id": "asst_abc123",
          "status": "completed",
          "started_at": 1699063292,
          "expires_at": 1699066891,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": 1699063391,
          "last_error": null,
          "model": "gpt-3.5-turbo",
          "instructions": "You are a helpful assistant.",
          "tools": [
            {
              "type": "function",
              "function": {
                "name": "get_weather",
                "description": "Determine weather in my location",
                "parameters": {
                  "location": "San Francisco, CA",
                  "unit": "c"
                }
              }
            }
          ],
          "file_ids": ["file-abc123"],
          "metadata": {
            "additional_info": "test"
          }
        }
        """
    static let cancelRun: String =
        """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699075072,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "cancelled",
          "started_at": 1699075072,
          "expires_at": 1699075672,
          "cancelled_at": 1699075092,
          "failed_at": null,
          "completed_at": null,
          "last_error": null,
          "model": "gpt-3.5-turbo",
          "instructions": "Provide instructions",
          "tools": [],
          "file_ids": ["file-abc123"],
          "metadata": {"key": "value"}
        }
        """

    static let createThreadAndRun: String =
        """
        {
          "id": "run_xyz123",
          "object": "thread.run",
          "created_at": 1699080000,
          "thread_id": "thread_xyz123",
          "assistant_id": "asst_xyz123",
          "status": "in_progress",
          "started_at": 1699080001,
          "expires_at": 1699080600,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": null,
          "last_error": null,
          "model": "gpt-3.5-turbo",
          "instructions": "Explain deep learning to a 5 year old.",
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "file_ids": ["file-xyz123"],
          "metadata": {"session": "1"}
        }
        """

    static let retrieveRunStep: String =
        """
        {
          "id": "step_abc123",
          "object": "thread.run.step",
          "created_at": 1699063291,
          "run_id": "run_abc123",
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "type": "message_creation",
          "status": "completed",
          "cancelled_at": null,
          "completed_at": 1699063291,
          "expired_at": null,
          "failed_at": null,
          "last_error": null,
          "step_details": {
            "type": "message_creation",
            "message_creation": {
              "message_id": "msg_abc123"
            }
          }
        }
        """

    static let listRunSteps: String =
        """
        {
          "object": "list",
          "data": [
            {
              "id": "step_xyz123",
              "object": "thread.run.step",
              "created_at": 1699080100,
              "run_id": "run_xyz123",
              "assistant_id": "asst_xyz123",
              "thread_id": "thread_xyz123",
              "type": "message_creation",
              "status": "completed",
              "cancelled_at": null,
              "completed_at": 1699080200,
              "expired_at": null,
              "failed_at": null,
              "last_error": null,
              "step_details": {
                "type": "message_creation",
                "message_creation": {
                  "message_id": "msg_xyz123"
                }
              }
            },
          ],
          "first_id": "step_xyz123",
          "last_id": "step_xyz456",
          "has_more": false
        }
        """

}
