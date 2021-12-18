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
    var contactImage = [UIImage]()
    var imageURL = [String]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Справочник"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://randomuser.me/api/?results=1000&inc=name,email,phone,picture") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(Contacts.self, from: data) {
                    DispatchQueue.main.async {
                        self.contacts = decodedResponse.results
                        self.tableView.reloadData()
                    }
                    return
                }
            }
            print("Fetch error")
        }.resume()
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
//        let image = contactImage[indexPath.row]
        
        // Setting information for a cell
        
//        cell.imageView?.layer.cornerRadius = 5
        
        cell.textLabel?.text = "\(contact.name.first) \(contact.name.last)"
//        cell.imageView?.image = image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let contact = contacts[indexPath.row]
            vc.detailedItem = contact
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}





