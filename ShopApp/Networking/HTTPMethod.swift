//
//  HTTPMethod.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPHeaderKey: String {
    case accept = "Accept"
    case contentType = "Content-Type"
}

enum HTTPHeaderValue: String {
    case json = "application/json"
}

struct HTTPHeaders {
    private var headers: [String: String] = [:]
    
    mutating func add(key: String, value: String) {
        headers[key] = value
    }
    
    mutating func remove(key: String) {
        headers[key] = nil
    }
    
    mutating func add(_ value: HTTPHeaderValue, forKey key: HTTPHeaderKey) {
        headers[key.rawValue] = value.rawValue
    }
    
    func toDictionary() -> [String: String] {
        return headers
    }
}
