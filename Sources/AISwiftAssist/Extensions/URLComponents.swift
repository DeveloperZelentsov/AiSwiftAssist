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
        components.scheme = Constants.constants.baseScheme
        components.host = Constants.constants.baseHost
        return components
    }

}
