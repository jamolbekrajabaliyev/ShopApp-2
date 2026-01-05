//
//  ProductViewModel.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

protocol ProductViewModelDelegate: AnyObject {
    func showLoading()
    func hideLoading()
    func onProductsLoaded(_ products: [WelcomeElement])
    func onError(_ message: String)
}

final class ProductViewModel {

    weak var delegate: ProductViewModelDelegate?
    private let service = ProductService()

    func loadProducts() {
        delegate?.showLoading()

        Task {
            do {
                let products = try await service.getProducts()
                await MainActor.run {
                    self.delegate?.hideLoading()
                    self.delegate?.onProductsLoaded(products)
                }
            } catch {
                await MainActor.run {
                    self.delegate?.hideLoading()
                    self.delegate?.onError(error.localizedDescription)
                }
            }
        }
    }
}
