//
//  DetailedViewController.swift
//  Phonebook
//
//  Created by Камиль on 18.01.2022.
//

import UIKit

class DetailedViewController: UIViewController {

    var detailedContact: Contact?

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
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

    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        guard let detailedContact = detailedContact else {
            return
        }

        view.backgroundColor = .background

        profileImageView.addGestureRecognizer(tapGesture)

        nameLabel.text = "\(detailedContact.name.first) \(detailedContact.name.last)"
        numberLabel.text = "Phone: \(detailedContact.phone)"
        emailLabel.text = "Email: \(detailedContact.email)"
        callButton.setTitle("Call (\(detailedContact.phone))", for: .normal)
        messageButton.setTitle("Message (\(detailedContact.email))", for: .normal)

        NetworkManager.loadImage(for: detailedContact.picture.large) { [weak self] image in
            guard let self = self else {
                return
            }
            
            self.profileImageView.image = image
        }
    }

    private func setupConstraints() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(numberLabel)
        view.addSubview(callButton)
        view.addSubview(messageButton)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),

            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),

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

    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let bigImageView = UIImageView(image: imageView.image)
        bigImageView.frame = UIScreen.main.bounds
        bigImageView.backgroundColor = .black
        bigImageView.contentMode = .scaleAspectFit
        bigImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        bigImageView.addGestureRecognizer(tap)
        view.addSubview(bigImageView)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
