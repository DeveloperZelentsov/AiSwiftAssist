//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

extension Data {
    func decode<T: Decodable>(model: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(model, from: self)
        } catch {
            print(error)
            throw error
        }
    }
}
