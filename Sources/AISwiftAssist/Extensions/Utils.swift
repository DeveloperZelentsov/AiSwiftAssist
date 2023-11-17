//
//  File.swift
//  
//
//  Created by Alexey on 11/15/23.
//

import Foundation

final class Utils {
    /// The method creates a [URLQueryItem] object from the passed structure, signed under the Encodable protocol.
    /// - Parameter object: Object of the structure signed under the Encodable protocol.
    /// - Returns: [URLQueryItem] object.
    static func createURLQueryItems<T: Encodable>(from object: T) -> [URLQueryItem]? {
        do {
            let json = try JSONEncoder().encode(object)
            let dictionary = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any]
            return dictionary?.map { URLQueryItem(name: $0, value: "\($1)") }
        } catch {
            return nil
        }
    }

    static func extractDomain(from url: String) -> (String?, String?, Int?) {
        let pattern = "(https?)://([^/]+)"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: url, options: [], range: NSRange(location: 0, length: url.utf16.count))

            if let match = matches.first {
                let schemeRange = match.range(at: 1)
                let hostRange = match.range(at: 2)

                let scheme = Range(schemeRange, in: url).map { String(url[$0]) }
                let fullHost = Range(hostRange, in: url).map { String(url[$0]) }

                if let fullHost = fullHost {
                    let hostComponents = fullHost.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: false)
                    let host = String(hostComponents[0])
                    let port = hostComponents.count > 1 ? Int(hostComponents[1]) : nil
                    return (scheme, host, port)
                }
            }
        } catch {
            print("Invalid regular expression")
        }
        return (nil, nil, nil)
    }

}
