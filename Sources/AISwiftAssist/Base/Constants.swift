//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

public enum Constants: Sendable {
    nonisolated(unsafe) public static var config: AISwiftAssistConfig = .empty
    nonisolated(unsafe) public static var constants: AISwiftAssistConstants = .default
}
