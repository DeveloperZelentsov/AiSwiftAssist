//
//  File.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import Foundation

extension ModelsAPITests {
    static let list: String =
    """
    {
      "object": "list",
      "data": [
        {
          "id": "model-id-0",
          "object": "model",
          "created": 1686935002,
          "owned_by": "organization-owner"
        },
        {
          "id": "model-id-1",
          "object": "model",
          "created": 1686935002,
          "owned_by": "organization-owner"
        },
        {
          "id": "model-id-2",
          "object": "model",
          "created": 1686935002,
          "owned_by": "openai"
        }
      ]
    }
    """

    static let retrieve: String =
                """
        {
          "id": "gpt-3.5-turbo-instruct",
          "object": "model",
          "created": 1686935002,
          "owned_by": "openai"
        }
        """
    
    static let delete: String =
                """
        {
          "id": "ft:gpt-3.5-turbo:acemeco:suffix:abc123",
          "object": "model",
          "deleted": true
        }
        """
}
