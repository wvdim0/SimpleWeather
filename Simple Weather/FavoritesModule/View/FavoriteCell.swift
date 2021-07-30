//
//  FavoriteCell.swift
//  Simple Weather
//
//  Created by Вадим Аписов on 01.07.2021.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    // MARK: - Properties

    static let cellID = "favoriteCell"

    // MARK: - UI

    private let cellImage: UIImageView = {
        let cellImage = UIImageView()

        cellImage.contentMode = .scaleAspectFit
        cellImage.image = UIImage(named: "City2")
        cellImage.translatesAutoresizingMaskIntoConstraints = false

        return cellImage
    }()

    private let label: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textAlignment = .left
        label.text = "Санкт-Петербург"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Layout

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellImage.heightAnchor.constraint(equalToConstant: 30),
            cellImage.widthAnchor.constraint(equalToConstant: 30),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),

            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }

    // MARK: - Configuring

    func configure(with favoritePlace: String) {
        label.text = favoritePlace
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        contentView.addSubview(cellImage)
        contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
