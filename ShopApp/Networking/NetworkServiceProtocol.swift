//
//  NetworkServiceProtocol.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    func request(_ endpoint: Endpoint) async throws
}

final class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.asURLRequest()
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        try validateStatusCode(httpResponse.statusCode)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func request(_ endpoint: Endpoint) async throws {
        let request = try endpoint.asURLRequest()
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        try validateStatusCode(httpResponse.statusCode)
    }
    
    private func validateStatusCode(_ statusCode: Int) throws {
        switch statusCode {
        case 200...299:
            return //Success
        case 401:
            throw NetworkError.unauthorized
        case 400...499:
            throw NetworkError.httpError(statusCode: statusCode, message: "Client error")
        case 500...599:
            throw NetworkError.httpError(statusCode: statusCode, message: "Server error")
        default:
            throw NetworkError.httpError(statusCode: statusCode, message: "Unknown error")
        }
    }
}
