//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

extension URLComponents {
    static var `default`: Self {
        var components: Self = .init()
        components.scheme = Constants.baseScheme
        components.host = Constants.baseHost
        return components
    }

}
