//
//  ProductsViewController.swift
//  ShopApp
//
//  Created by Leon on 12/17/25.
//

import UIKit

 class ProductsViewController: UIViewController {

    private let viewModel = ProductViewModel()
    private var allProducts: [WelcomeElement] = []
    private var filteredProducts: [WelcomeElement] = []

    private let categories = Categorys.allCategories
    private var selectedCategory: Categorys?

    private let loader = UIActivityIndicatorView(style: .large)

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search products..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            if section == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .estimated(120),
                                      heightDimension: .absolute(40))
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .estimated(120),
                                      heightDimension: .absolute(40)),
                    subitems: [item]
                )
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .continuous
                sectionLayout.interGroupSpacing = 10
                sectionLayout.contentInsets = .init(top: 16, leading: 12, bottom: 16, trailing: 12)
                return sectionLayout
            }
            
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                  heightDimension: .estimated(220))
            )
            item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .estimated(220)),
                subitems: [item, item]
            )
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.interGroupSpacing = 12
            sectionLayout.contentInsets = .init(top: 16, leading: 8, bottom: 16, trailing: 8)
            return sectionLayout
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.register(ProductGridCell.self, forCellWithReuseIdentifier: ProductGridCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shop"
        view.backgroundColor = .systemBackground

        viewModel.delegate = self
        setupUI()
        viewModel.loadProducts()

        searchBar.delegate = self
    }

    private func setupUI() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(loader)

        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        section == 0 ? categories.count : filteredProducts.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.id,
                for: indexPath
            ) as! CategoryCell
            cell.configure(categories[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductGridCell.id,
            for: indexPath
        ) as! ProductGridCell
        cell.configure(filteredProducts[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedCategory = categories[indexPath.item]
            if selectedCategory == .all {
                filteredProducts = allProducts
            } else {
                filteredProducts = allProducts.filter { $0.category == selectedCategory }
            }
            collectionView.reloadSections(IndexSet(integer: 1))
            return
        }
        let product = filteredProducts[indexPath.item]
        let vc = ProductDetailViewController(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ProductViewModelDelegate
extension ProductsViewController: ProductViewModelDelegate {
    func showLoading() { loader.startAnimating() }
    func hideLoading() { loader.stopAnimating() }
    func onProductsLoaded(_ products: [WelcomeElement]) {
        allProducts = products
        filteredProducts = products
        collectionView.reloadData()
    }
    func onError(_ message: String) { print(message) }
}

// MARK: - UISearchBarDelegate
extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredProducts = allProducts
        } else {
            filteredProducts = allProducts.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadSections(IndexSet(integer: 1))
    }
}
