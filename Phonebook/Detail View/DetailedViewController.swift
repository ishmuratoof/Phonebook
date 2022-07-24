//
//  DetailedViewController.swift
//  Phonebook
//
//  Created by Камиль on 18.01.2022.
//

import UIKit

class DetailedViewController: UIViewController {

    var detailedContact: Contact!

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        return image
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        return button
    }()

    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        return button
    }()

    init(for detailedContact: Contact) {
        super.init(nibName: nil, bundle: nil)
        self.detailedContact = detailedContact
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        loadImage()
    }

    private func setupUI() {
        view.backgroundColor = .background

        nameLabel.text = "\(detailedContact.name.first) \(detailedContact.name.last)"
        numberLabel.text = "Phone: \(detailedContact.phone)"
        emailLabel.text = "Email: \(detailedContact.email)"
        callButton.setTitle("Call (\(detailedContact.phone))", for: .normal)
        messageButton.setTitle("Message (\(detailedContact.email))", for: .normal)
    }

    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(numberLabel)
        view.addSubview(callButton)
        view.addSubview(messageButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),

            numberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),

            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),

            callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callButton.bottomAnchor.constraint(equalTo: messageButton.topAnchor, constant: -10),

            messageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            messageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }

    private func loadImage() {
        DispatchQueue.global().async {
            let imageUrl = URL(string: self.detailedContact.picture.large)!
            let imageData = try! Data(contentsOf: imageUrl)
            let image = UIImage(data: imageData)

            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
