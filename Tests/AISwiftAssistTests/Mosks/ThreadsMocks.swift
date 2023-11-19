//
//  File.swift
//  
//
//  Created by Alexey on 11/20/23.
//

import Foundation

extension ThreadsAPITests {
    static let create: String =
    """
    {
      "id": "thread_abc123",
      "object": "thread",
      "created_at": 1699012949,
      "metadata": {}
    }
    """

    static let retrieve: String =
                """
        {
          "id": "thread_abc123",
          "object": "thread",
          "created_at": 1699014083,
          "metadata": {}
        }
        """

    static let modify: String =
    """
        {
          "id": "thread_abc123",
          "object": "thread",
          "created_at": 1699014083,
          "metadata": {
            "modified": "true",
            "user": "abc123"
          }
        }
        """

    static let delete: String =
                """
        {
          "id": "thread_abc123",
          "object": "thread.deleted",
          "deleted": true
        }
        """
}
