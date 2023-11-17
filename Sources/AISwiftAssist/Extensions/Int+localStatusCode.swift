//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

extension Int {
    var localStatusCode: String {
        return HTTPURLResponse.localizedString(forStatusCode: self)
    }
}
