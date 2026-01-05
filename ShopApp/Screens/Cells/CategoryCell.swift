//
//  CategoryCell.swift
//  ShopApp
//
//  Created by Leon on 12/16/25.
//

import UIKit

 class CategoryCell: UICollectionViewCell {

    static let id = "CategoryCell"
    private let titleLabel = UILabel()

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1

        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(_ category: Categorys) {
        titleLabel.text = category.rawValue.capitalized
        updateAppearance()
    }

    private func updateAppearance() {
        if isSelected {
            contentView.backgroundColor = UIColor.systemBlue
            titleLabel.textColor = UIColor.white
            contentView.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            contentView.backgroundColor = UIColor { trait in
                trait.userInterfaceStyle == .dark ? UIColor.systemGray6 : UIColor.systemGroupedBackground
            }
            titleLabel.textColor = UIColor.label
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
