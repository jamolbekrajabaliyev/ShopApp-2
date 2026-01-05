//
//  APIRouter.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import Foundation

enum APIRouter {
    case getProducts
    case getProduct(id: Int)
    case createOrder(params: [String: Any])
}

extension APIRouter: Endpoint {

    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getProduct(let id):
            return "/products/\(id)"
        case .createOrder:
            return "/orders"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts, .getProduct:
            return .get
        case .createOrder:
            return .post
        }
    }
    
    var queryParameters: [String : Any]? {
        return nil
    }
    
    var bodyParameters: [String : Any]? {
        switch self {
        case .createOrder(let params):
            return params
        default:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        var header = HTTPHeaders()
        header.add(.json, forKey: .accept)
        header.add(.json, forKey: .contentType)
        return header
    }
}
