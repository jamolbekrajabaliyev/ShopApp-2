//
//  EndPoint.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var queryParameters: [String: Any]? { get }
    var bodyParameters: [String: Any]? { get }
    var timeoutInterval: TimeInterval { get }
}

extension Endpoint {

    var timeoutInterval: TimeInterval { 60 }

    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(.json, forKey: .contentType)
        headers.add(.json, forKey: .accept)
        return headers
    }

    var queryParameters: [String: Any]? { nil }
    var bodyParameters: [String: Any]? { nil }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval

        headers.toDictionary().forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        if let bodyParameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
        }

        print("URL:", request.url?.absoluteString ?? "")
        return request
    }
}
