//
//  DetailedViewController.swift
//  Phonebook
//
//  Created by Камиль on 18.01.2022.
//

import UIKit

class DetailedViewController: UIViewController {

    var detailedContact: Contact!

    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var numberLabel: UILabel!
    private var callButton: UIButton!
    private var messageButton: UIButton!

    init(for detailedContact: Contact) {
        super.init(nibName: nil, bundle: nil)
        self.detailedContact = detailedContact
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        callButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        messageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        view.addSubview(imageView!)
        view.addSubview(nameLabel!)
        view.addSubview(numberLabel!)
        view.addSubview(emailLabel!)
        view.addSubview(callButton!)
        view.addSubview(messageButton!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadImage()
    }

    private func setupUI() {
        view.backgroundColor = .background

        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        callButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.translatesAutoresizingMaskIntoConstraints = false

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

        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true

        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)

        callButton.configuration = .tinted()
        messageButton.configuration = .tinted()

        nameLabel.text = "\(detailedContact.name.first) \(detailedContact.name.last)"
        numberLabel.text = "Phone: \(detailedContact.phone)"
        emailLabel.text = "Email: \(detailedContact.email)"
        callButton.setTitle("Call (\(detailedContact.phone))", for: .normal)
        messageButton.setTitle("Message (\(detailedContact.email))", for: .normal)
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
