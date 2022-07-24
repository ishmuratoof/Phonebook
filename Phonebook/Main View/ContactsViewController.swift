//
//  ContactsViewController.swift
//  Phonebook
//
//  Created by Камиль on 23.07.2022.
//

import UIKit

class ContactsViewController: UIViewController {

    private var tableView = UITableView()
    private var contactsArray = [Contact]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupUI()
        setupConstraints()

        ContactsFetcher.getContacts { contacts in
            self.contactsArray = contacts
            self.tableView.reloadData()
        }
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupUI() {
        title = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        view.backgroundColor = .background
    }

    private func setupConstraints() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contactsArray[indexPath.row]
        cell.textLabel?.text = "\(contact.name.first) \(contact.name.last)"
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactsArray[indexPath.row]
        let detailedView = DetailedViewController(for: contact)
        navigationController?.pushViewController(detailedView, animated: true)
    }
}
