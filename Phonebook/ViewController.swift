//
//  ViewController.swift
//  Phonebook
//
//  Created by Камиль on 03.10.2021.
//

import UIKit

class ViewController: UITableViewController {

    var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Справочник"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let urlString = "https://randomuser.me/api/?results=10&inc=email,phone"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonContacts = try? decoder.decode(Contacts.self, from: json) {
            contacts = jsonContacts.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.email) \(contact.phone)"
        return cell
    }
}





