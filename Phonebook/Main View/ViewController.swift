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
        loadImage()
        print(contactImage.count)
    }
    
    // Loading contact data
    
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
                        for result in decodedResponse.results {
                            self.imageURL.append(result.picture.large)
                        }
                        self.tableView.reloadData()
                    }
                    return
                }
            }
            print("Fetch error")
        }.resume()
    }
    
    // Loading contact image
    
    func loadImage() {
        for url in imageURL {
            let pictureURL = URL(string: url)!
            
            let request = URLRequest(url: pictureURL)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.contactImage.append(UIImage(data: data)!)
                    }
                }
            }.resume()
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
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.name.first) \(contact.name.last)"
        return cell
    }
    
    // Passing information to detailed view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let detailedView = DetailedViewController()
        detailedView.detailedContact = contact
        navigationController?.pushViewController(detailedView, animated: true)
    }
}





