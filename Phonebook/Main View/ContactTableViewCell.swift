//
//  ContactTableViewCell.swift
//  Phonebook
//
//  Created by Камиль on 23.07.2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var contact: Contact? {
        didSet {
            setupUI()
        }
    }

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let contact = contact else {
            return
        }

        nameLabel.text = "\(contact.name.first) \(contact.name.last)"

        NetworkManager.loadImage(for: contact.picture.large) { image in
            self.profileImageView.image = image
        }
    }

    private func setupConstraints() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ])
    }
}
