//
//  ProductRequestModel.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

struct ProductRequestModel {
    let category: String?
    let searchQuery: String?
    let page: Int?
    
    init(
        category: String? = nil,
        searchQuery: String? = nil,
        page: Int? = nil
    ) {
        self.category = category
        self.searchQuery = searchQuery
        self.page = page
    }
}
