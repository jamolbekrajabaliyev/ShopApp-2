//
//  SearchBar.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import UIKit

class SearchBarView: UIView, UISearchBarDelegate {

    let searchBar = UISearchBar()
    var onSearchTextChanged: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        searchBar.placeholder = "Search products..."
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        backgroundColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.black : UIColor.systemGroupedBackground
        }

        searchBar.barTintColor = backgroundColor
        searchBar.searchTextField.backgroundColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.systemGray5 : UIColor.white
        }
        searchBar.searchTextField.textColor = UIColor.label 
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onSearchTextChanged?(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
