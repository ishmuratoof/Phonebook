//
//  ContactsViewController.swift
//  Phonebook
//
//  Created by Камиль on 23.07.2022.
//

import UIKit

class ContactsViewController: UIViewController {

    private var tableView = UITableView()
    private var searchController = UISearchController()

    private var contactsArray = [Contact]()
    private var searchedContacts = [Contact]()
    private var isSearching: Bool {
        return searchController.isActive
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchBar()
        setupUI()
        setupConstraints()

        NetworkManager.loadContacts { contacts in
            self.contactsArray = contacts
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    private func setupTableView() {
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
    }

    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.automaticallyShowsCancelButton = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search contacts"
    }

    private func setupUI() {
        title = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        view.backgroundColor = .background
    }

    private func setupConstraints() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedContacts.count : contactsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        let contact: Contact

        if isSearching {
            contact = searchedContacts[indexPath.row]
        } else {
            contact = contactsArray[indexPath.row]
        }

        cell.contact = contact
        cell.accessoryType = .disclosureIndicator
        
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

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }

        searchedContacts = contactsArray.filter( { $0.name.first.lowercased().contains(text.lowercased()) } )
        tableView.reloadData()
    }
}
