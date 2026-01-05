//
//  ProductCell.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.

import UIKit

class ProductGridCell: UICollectionViewCell {

    static let id = "ProductGridCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let idLabel = UILabel()
    private let ratingIcon = UIImageView()
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        contentView.backgroundColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor.systemGray6 : UIColor.white
        }
        contentView.layer.cornerRadius = 14

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        idLabel.font = .systemFont(ofSize: 10)
        idLabel.textColor = .secondaryLabel
        idLabel.translatesAutoresizingMaskIntoConstraints = false

        ratingIcon.tintColor = .systemYellow
        ratingIcon.translatesAutoresizingMaskIntoConstraints = false

        ratingLabel.font = .systemFont(ofSize: 12)
        ratingLabel.textColor = .secondaryLabel
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.font = .boldSystemFont(ofSize: 14)
        priceLabel.textColor = .systemBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(ratingIcon)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            idLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            idLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            ratingIcon.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 6),
            ratingIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingIcon.widthAnchor.constraint(equalToConstant: 14),
            ratingIcon.heightAnchor.constraint(equalToConstant: 14),

            ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 4),

            priceLabel.topAnchor.constraint(equalTo: ratingIcon.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(_ product: WelcomeElement) {
        titleLabel.text = product.title
        idLabel.text = "ID: \(product.id)"
        priceLabel.text = "$\(product.price)"
        ratingLabel.text = "\(product.rating.rate) (\(product.rating.count))"

        let rate = product.rating.rate
        if rate >= 4 {
            ratingIcon.image = UIImage(systemName: "star.fill")
        } else if rate >= 3 {
            ratingIcon.image = UIImage(systemName: "star.leadinghalf.filled")
        } else {
            ratingIcon.image = UIImage(systemName: "star")
        }

        if let url = URL(string: product.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
