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
            guard let contact = contact else {
                return
            }

            nameLabel.text = "\(contact.name.first) \(contact.name.last)"

            NetworkManager.loadImage(for: contact.picture.large) { [weak self] image in
                guard let self = self else {
                    return
                }
                
                self.profileImageView.image = image
            }
        }
    }

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.black.cgColor
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

    private func setupConstraints() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        profileImageView.image = UIImage(systemName: "person.circle")
    }
}
