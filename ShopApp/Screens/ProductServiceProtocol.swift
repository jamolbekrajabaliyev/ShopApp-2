//
//  ProductServiceProtocol.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

protocol ProductServiceProtocol {
    func getProducts() async throws -> [WelcomeElement]
}

final class ProductService: ProductServiceProtocol {

    func getProducts() async throws -> [WelcomeElement] {
        let url = URL(string: "https://fakestoreapi.com/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([WelcomeElement].self, from: data)
    }
}
