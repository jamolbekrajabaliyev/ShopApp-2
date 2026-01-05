//
//  ProductDelegate.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.

import Foundation

enum LoaderState {
    case loading
    case loaded
}

protocol LoaderViewDelegate: AnyObject {
    func loader(_ state: LoaderState)
}
