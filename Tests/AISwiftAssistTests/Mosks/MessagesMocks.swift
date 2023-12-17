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
          "id": "msg_SM7CyvQn3UnrAyOh96TGN5jR",
          "object": "thread.message",
          "created_at": 1702586152,
          "thread_id": "thread_11LlFPiPpEw7WhZr0AqB2WhF",
          "role": "assistant",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "I now have full annotations for every date mentioned in the file",
                "annotations": [
                  {
                    "type": "file_citation",
                    "text": "【21†source】",
                    "start_index": 136,
                    "end_index": 147,
                    "file_citation": {
                      "file_id": "",
                      "quote": "adfadlfkjamdf"
                    }
                  },
                  {
                    "type": "file_citation",
                    "text": "【22†source】",
                    "start_index": 197,
                    "end_index": 208,
                    "file_citation": {
                      "file_id": "",
                      "quote": "01.12.202318"
                    }
                  },
                  {
                    "type": "file_citation",
                    "text": "【29†source】",
                    "start_index": 287,
                    "end_index": 298,
                    "file_citation": {
                      "file_id": "",
                      "quote": "ajfnailfbnloabiufnliajnsfl"
                    }
                  },
                  {
                    "type": "file_citation",
                    "text": "【33†source】",
                    "start_index": 378,
                    "end_index": 389,
                    "file_citation": {
                      "file_id": "",
                      "quote": "DXB"
                    }
                  }
                ]
              }
            }
          ],
          "file_ids": [],
          "assistant_id": "asst_wAI24kgbPjUpBqnEbsyjS8iO",
          "run_id": "run_RapQjuYYvH1gpyOQB2DSAurf",
          "metadata": {}
        },
        {
          "id": "msg_oacFAKp8WbIKYnV2Wmsyh5aE",
          "object": "thread.message",
          "created_at": 1702560337,
          "thread_id": "thread_11LlFPiPpEw7WhZr0AqB2WhF",
          "role": "assistant",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "Привет! Как я могу помочь вам сегодня?",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "assistant_id": "asst_wAI24kgbPjUpBqnEbsyjS8iO",
          "run_id": "run_9P57TYv8dxBPQkHK8plrNztk",
          "metadata": {}
        },
        {
          "id": "msg_V8hf7PCvWceW4DpQKpQV83Ia",
          "object": "thread.message",
          "created_at": 1702560334,
          "thread_id": "thread_11LlFPiPpEw7WhZr0AqB2WhF",
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "привет",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "assistant_id": null,
          "run_id": null,
          "metadata": {}
        }
      ],
      "first_id": "msg_SM7CyvQn3UnrAyOh96TGN5jR",
      "last_id": "msg_V8hf7PCvWceW4DpQKpQV83Ia",
      "has_more": false
    }
    """

    static let modify: String =
        """
               {
                 "id": "12345",
                 "object": "thread.message",
                 "created_at": 1639530000,
                 "thread_id": "thread123",
                 "role": "assistant",
                 "content": [
                   {
                     "type": "text",
                     "text": {
                       "value": "This is a text message with annotations.",
                       "annotations": [

                         {
                           "type": "file_citation",
                           "text": "document link",
                           "file_citation": {
                             "file_id": "file123",
                             "quote": "A quote from the file"
                           },
                           "start_index": 0,
                           "end_index": 23
                         },
                         {
                           "type": "file_path",
                           "text": "path to file",
                           "file_path": {
                             "file_id": "file456"
                           },
                           "start_index": 24,
                           "end_index": 37
                         }
                       ]
                     }
                   },
                   {
                     "type": "image_file",
                     "image_file": {
                       "file_id": "image789"
                     }
                   }
                 ],
                 "assistant_id": "assistant123",
                 "run_id": "run123",
                 "file_ids": ["file123", "file456", "image789"],
                 "metadata": {
                   "key1": "value1",
                   "key2": "value2"
                 }
               }
        """

    static let retrieve: String =
    """
               {
                 "id": "12345",
                 "object": "thread.message",
                 "created_at": 1639530000,
                 "thread_id": "thread123",
                 "role": "assistant",
                 "content": [
                   {
                     "type": "text",
                     "text": {
                       "value": "This is a text message with annotations.",
                       "annotations": [

                         {
                           "type": "file_citation",
                           "text": "document link",
                           "file_citation": {
                             "file_id": "file123",
                             "quote": "A quote from the file"
                           },
                           "start_index": 0,
                           "end_index": 23
                         },
                         {
                           "type": "file_path",
                           "text": "path to file",
                           "file_path": {
                             "file_id": "file456"
                           },
                           "start_index": 24,
                           "end_index": 37
                         }
                       ]
                     }
                   },
                   {
                     "type": "image_file",
                     "image_file": {
                       "file_id": "image789"
                     }
                   }
                 ],
                 "assistant_id": "assistant123",
                 "run_id": "run123",
                 "file_ids": ["file123", "file456", "image789"],
                 "metadata": {
                   "key1": "value1",
                   "key2": "value2"
                 }
               }
        """

    static let create: String =
                """
               {
                 "id": "12345",
                 "object": "thread.message",
                 "created_at": 1639530000,
                 "thread_id": "thread123",
                 "role": "assistant",
                 "content": [
                   {
                     "type": "text",
                     "text": {
                       "value": "This is a text message with annotations.",
                       "annotations": [

                         {
                           "type": "file_citation",
                           "text": "document link",
                           "file_citation": {
                             "file_id": "file123",
                             "quote": "A quote from the file"
                           },
                           "start_index": 0,
                           "end_index": 23
                         },
                         {
                           "type": "file_path",
                           "text": "path to file",
                           "file_path": {
                             "file_id": "file456"
                           },
                           "start_index": 24,
                           "end_index": 37
                         }
                       ]
                     }
                   },
                   {
                     "type": "image_file",
                     "image_file": {
                       "file_id": "image789"
                     }
                   }
                 ],
                 "assistant_id": "assistant123",
                 "run_id": "run123",
                 "file_ids": ["file123", "file456", "image789"],
                 "metadata": {
                   "key1": "value1",
                   "key2": "value2"
                 }
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
