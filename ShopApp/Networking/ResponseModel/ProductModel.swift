//
//  ProductModel.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

struct WelcomeElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Categorys
    let image: String
    let rating: Rating
}

enum Categorys: String, Codable, CaseIterable {
    case all = "all"
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"

    static let allCategories: [Categorys] = [
        .all,
        .electronics,
        .jewelery,
        .menSClothing,
        .womenSClothing
    ]
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
