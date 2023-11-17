//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

extension Data {
    func decode<T: Decodable>(model: T.Type) -> T? {
        return try? JSONDecoder().decode(model, from: self)
    }
}
