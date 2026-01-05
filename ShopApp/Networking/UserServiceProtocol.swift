//
//  UserServiceProtocol.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

protocol UserServiceProtocol {
    func getProducts() async throws -> [WelcomeElement]
    func getProduct(id: Int) async throws -> WelcomeElement
}

final class Product: UserServiceProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func getProducts() async throws -> [WelcomeElement] {
        return try await networkService.request(
            APIRouter.getProducts
        )
    }

    func getProduct(id: Int) async throws -> WelcomeElement {
        return try await networkService.request(
            APIRouter.getProduct(id: id)
        )
    }
}
