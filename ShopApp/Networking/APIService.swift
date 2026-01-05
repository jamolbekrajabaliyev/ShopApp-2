//
//  APIService.swift
//  ShopApp
//
//  Created by Leon on 12/17/25.
//

import Foundation

final class APIService {

    func fetchProducts() async throws -> [WelcomeElement] {
        let url = URL(string: "https://fakestoreapi.com/products")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([WelcomeElement].self, from: data)
    }
}
