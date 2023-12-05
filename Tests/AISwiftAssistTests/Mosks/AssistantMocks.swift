//
//  File.swift
//  
//
//  Created by Alexey on 11/19/23.
//

import Foundation

extension AssistantsAPITests {
    static let list: String =
                """
    {
      "object": "list",
      "data": [
        {
          "id": "asst_abc123",
          "object": "assistant",
          "created_at": 1698982736,
          "name": "Coding Tutor",
          "description": null,
          "model": "gpt-4",
          "instructions": "You are a helpful assistant designed to make me better at coding!",
          "tools": [],
          "file_ids": [],
          "metadata": {}
        },
        {
          "id": "asst_abc456",
          "object": "assistant",
          "created_at": 1698982718,
          "name": "My Assistant",
          "description": null,
          "model": "gpt-4",
          "instructions": "You are a helpful assistant designed to make me better at coding!",
          "tools": [],
          "file_ids": [],
          "metadata": {}
        },
        {
          "id": "asst_abc789",
          "object": "assistant",
          "created_at": 1698982643,
          "name": null,
          "description": null,
          "model": "gpt-4",
          "instructions": null,
          "tools": [],
          "file_ids": [],
          "metadata": {}
        }
      ],
      "first_id": "asst_abc123",
      "last_id": "asst_abc789",
      "has_more": false
    }
    """
    
    static let create: String =
                """
        {
          "id": "asst_abc123",
          "object": "assistant",
          "created_at": 1698984975,
          "name": "Math Tutor",
          "description": null,
          "model": "gpt-4",
          "instructions": "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "file_ids": [],
          "metadata": {}
        }
        """
    
    static let retrieve: String =
        """
        {
          "id": "asst_abc123",
          "object": "assistant",
          "created_at": 1699009709,
          "name": "HR Helper",
          "description": null,
          "model": "gpt-4",
          "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies.",
          "tools": [
            {
              "type": "retrieval"
            }
          ],
          "file_ids": [
            "file-abc123"
          ],
          "metadata": {}
        }
        """
    
    static let modify: String =
        """
        {
          "id": "asst_abc123",
          "object": "assistant",
          "created_at": 1699009709,
          "name": "HR Helper",
          "description": null,
          "model": "gpt-4",
          "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.",
          "tools": [
            {
              "type": "retrieval"
            }
          ],
          "file_ids": [
            "file-abc123",
            "file-abc456"
          ],
          "metadata": {}
        }
        """
    
    static let delete: String =
    """
    {
      "id": "asst_abc123",
      "object": "assistant.deleted",
      "deleted": true
    }
    """
    
    static let createFile: String =
        """
        {
          "id": "file-abc123",
          "object": "assistant.file",
          "created_at": 1699055364,
          "assistant_id": "asst_abc123"
        }
        """
    
    static let retrieveFile: String =
        """
        {
          "id": "file-abc123",
          "object": "assistant.file",
          "created_at": 1699055364,
          "assistant_id": "asst_abc123"
        }
        """
    
    static let deleteFile: String =
        """
        {
          "id": "file-abc123",
          "object": "assistant.file.deleted",
          "deleted": true
        }
        """
    
    static let listFiles: String =
        """
        {
          "object": "list",
          "data": [
            {
              "id": "file-abc123",
              "object": "assistant.file",
              "created_at": 1699060412,
              "assistant_id": "asst_abc123"
            },
            {
              "id": "file-abc456",
              "object": "assistant.file",
              "created_at": 1699060412,
              "assistant_id": "asst_abc123"
            }
          ],
          "first_id": "file-abc123",
          "last_id": "file-abc456",
          "has_more": false
        }
        """
}

