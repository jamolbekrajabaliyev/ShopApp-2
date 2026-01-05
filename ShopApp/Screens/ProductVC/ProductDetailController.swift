//
//  ProductDetailController.swift
//  ShopApp
//
//  Created by Leon on 12/17/25.
//

import UIKit

 class ProductDetailViewController: UIViewController {

    private let product: WelcomeElement

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let ratingButton = UIButton(type: .system)
    private let ratingLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()

    init(product: WelcomeElement) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product"
        view.backgroundColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        }
        setupUI()
        configure()
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 260).isActive = true

        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label

        categoryLabel.font = .systemFont(ofSize: 14)
        categoryLabel.textColor = .secondaryLabel

        ratingButton.tintColor = .systemYellow
        ratingButton.addTarget(self, action: #selector(ratingTapped), for: .touchUpInside)

        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.textColor = .secondaryLabel

        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .label

        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.textColor = .systemBlue

        let ratingStack = UIStackView(arrangedSubviews: [ratingButton, ratingLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 6
        ratingStack.alignment = .center

        let stack = UIStackView(arrangedSubviews: [
            imageView, titleLabel, categoryLabel, ratingStack, descriptionLabel, priceLabel
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            ratingButton.widthAnchor.constraint(equalToConstant: 20),
            ratingButton.heightAnchor.constraint(equalToConstant: 20),

            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func configure() {
        titleLabel.text = product.title
        categoryLabel.text = product.category.rawValue.capitalized
        ratingLabel.text = "\(product.rating.rate) (\(product.rating.count))"
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"

        let rate = product.rating.rate
        let iconName: String

        if rate >= 4 {
            iconName = "star.fill"
        } else if rate >= 3 {
            iconName = "star.leadinghalf.filled"
        } else {
            iconName = "star"
        }

        ratingButton.setImage(UIImage(systemName: iconName), for: .normal)

        if let url = URL(string: product.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

    @objc private func ratingTapped() {
        let alert = UIAlertController(
            title: "Rating",
            message: "\(product.rating.rate)\nVotes: \(product.rating.count)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
