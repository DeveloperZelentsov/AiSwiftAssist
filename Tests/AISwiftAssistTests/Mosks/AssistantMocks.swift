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
          "id": "asst_advanced_full",
          "object": "assistant",
          "created_at": 1709800000,
          "name": "Advanced Assistant",
          "description": "Fully featured assistant with comprehensive tools and strict output control.",
          "model": "gpt-4-turbo",
          "instructions": "You are a professional assistant with advanced functionality, tool support, and strict output controls.",
          "tools": [
            {"type": "code_interpreter"},
            {"type": "file_search"},
            {"type": "function", "function": {"name": "fetchData", "description": "Fetches data from external sources."}}
          ],
          "file_ids": ["file_adv_01", "file_adv_02"],
          "metadata": {"role": "advanced", "version": "1.0"}
        },
        {
          "id": "asst_professional",
          "object": "assistant",
          "created_at": 1709800500,
          "name": "Professional Assistant",
          "description": "Professional assistant designed for complex tasks and detailed analysis.",
          "model": "gpt-4-turbo",
          "instructions": "You provide detailed and professional assistance for complex and analytical tasks.",
          "tools": [{"type": "code_interpreter"}, {"type": "file_search"}],
          "file_ids": ["file_pro_01"],
          "metadata": {"role": "professional", "version": "1.0"}
        },
        {
          "id": "asst_standard",
          "object": "assistant",
          "created_at": 1709801000,
          "name": "Standard Assistant",
          "description": "A standard assistant suitable for everyday tasks.",
          "model": "gpt-4",
          "instructions": "You are a helpful assistant equipped with basic tools for everyday tasks.",
          "tools": [{"type": "file_search"}],
          "file_ids": ["file_std_01"],
          "metadata": {"role": "standard", "version": "0.9"}
        },
        {
          "id": "asst_intermediate",
          "object": "assistant",
          "created_at": 1709801200,
          "name": "Intermediate Assistant",
          "description": "Intermediate assistant with moderate capabilities.",
          "model": "gpt-4",
          "instructions": "You help users with moderate complexity tasks efficiently.",
          "tools": [],
          "file_ids": [],
          "metadata": {"role": "intermediate", "version": "0.8"}
        },
        {
          "id": "asst_basic",
          "object": "assistant",
          "created_at": 1709801500,
          "name": "Basic Assistant",
          "description": "Simple assistant for basic queries.",
          "model": "gpt-3.5-turbo",
          "instructions": "You assist with basic queries and simple tasks.",
          "tools": [],
          "file_ids": [],
          "metadata": {"role": "basic", "version": "0.7"}
        },
        {
          "id": "asst_simple",
          "object": "assistant",
          "created_at": 1709801800,
          "name": "Simple Assistant",
          "description": null,
          "model": "gpt-3.5-turbo",
          "instructions": "You are a simple and friendly assistant for straightforward tasks.",
          "tools": [],
          "file_ids": [],
          "metadata": {}
        },
        {
          "id": "asst_minimal",
          "object": "assistant",
          "created_at": 1709802000,
          "name": "Minimal Assistant",
          "description": null,
          "model": "gpt-3.5-turbo",
          "instructions": null,
          "tools": [],
          "file_ids": [],
          "metadata": {}
        }
      ],
      "first_id": "asst_advanced_full",
      "last_id": "asst_minimal",
      "has_more": false
    }
    """

    
    static let create: String =
                """
                {
                  "id": "asst_advanced_full",
                  "object": "assistant",
                  "created_at": 1709800000,
                  "name": "Advanced Assistant",
                  "description": "Fully featured assistant with comprehensive tools and strict output control.",
                  "model": "gpt-4-turbo",
                  "instructions": "You are a professional assistant with advanced functionality, tool support, and strict output controls.",
                  "tools": [
                    {"type": "code_interpreter"},
                    {"type": "file_search"},
                    {"type": "function", "function": {"name": "fetchData", "description": "Fetches data from external sources."}}
                  ],
                  "file_ids": ["file_adv_01", "file_adv_02"],
                  "metadata": {"role": "advanced", "version": "1.0"}
                }
        """
    
    static let retrieve: String =
        """
                {
                  "id": "asst_advanced_full",
                  "object": "assistant",
                  "created_at": 1709800000,
                  "name": "Advanced Assistant",
                  "description": "Fully featured assistant with comprehensive tools and strict output control.",
                  "model": "gpt-4-turbo",
                  "instructions": "You are a professional assistant with advanced functionality, tool support, and strict output controls.",
                  "tools": [
                    {"type": "code_interpreter"},
                    {"type": "file_search"},
                    {"type": "function", "function": {"name": "fetchData", "description": "Fetches data from external sources."}}
                  ],
                  "file_ids": ["file_adv_01", "file_adv_02"],
                  "metadata": {"role": "advanced", "version": "1.0"}
                }
        """
    
    static let modify: String =
        """
                {
                  "id": "asst_advanced_full",
                  "object": "assistant",
                  "created_at": 1709800000,
                  "name": "Advanced",
                  "description": "Fully featured assistant with comprehensive tools and strict output control.",
                  "model": "gpt-4",
                  "instructions": "You are a professional assistant with advanced functionality, tool support, and strict output controls.",
                  "tools": [
                    {"type": "code_interpreter"},
                    {"type": "file_search"},
                    {"type": "function", "function": {"name": "fetchData", "description": "Fetches data from external sources."}}
                  ],
                  "file_ids": ["file_adv_01", "file_adv_02"],
                  "metadata": {"role": "advanced", "version": "1.0"}
                }
        """
    
    static let delete: String =
    """
    {
      "id": "asst_advanced_full",
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

