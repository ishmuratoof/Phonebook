//
//  ViewController.swift
//  Phonebook
//
//  Created by Камиль on 03.10.2021.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [Contact]()
    var searchedContacts = [Contact]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Справочник"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let urlString = "https://randomuser.me/api/?results=1000&inc=name,email,phone,picture"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    // A finction to parse data from URL
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonContacts = try? decoder.decode(Contacts.self, from: json) {
            contacts = jsonContacts.results
            tableView.reloadData()
        }
    }
    
    // Setting a number of rows in tableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedContacts.count
        } else {
            return contacts.count
        }
    }
    
    // Filling a cell with information
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        
        // Getting information for each contact
        
        let contact = contacts[indexPath.row]
        
        // Getting an image from URL
        
//        let imageUrl = URL(string: contact.picture.thumbnail)!
//        let imageData = try! Data(contentsOf: imageUrl)
//        let image = UIImage(data: imageData)
        
        // Setting information for a cell
        
        cell.textLabel?.text = "\(contact.name.first) \(contact.name.last)"
//        cell.imageView?.image = image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let contact = contacts[indexPath.row]

            vc.userName?.text = "\(contact.name.first) \(contact.name.last)"
            vc.phone?.text = contact.phone
            vc.email?.text = contact.email
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}





