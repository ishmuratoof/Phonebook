//
//  ViewController.swift
//  Phonebook
//
//  Created by Камиль on 03.10.2021.
//
 
import UIKit

class ViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private var contactsArray = [Contact]()
    private var searchedContactsArray = [Contact]()
    private var isSearching = false
    private var imagesArray = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        
        loadData()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.placeholder = "Search contacts"
        searchBar.searchTextField.delegate = self
    }
    
    func loadData() {
        let url = URL(string: "https://randomuser.me/api/?results=5&inc=name,email,phone,picture")!

        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Contacts.self, from: data) {

                for result in decoded.results {
                    let url = URL(string: result.picture.large)!
                    let data = try! Data(contentsOf: url)
                    let image = UIImage(data: data)
                    self.imagesArray.append(image)
                }

                DispatchQueue.main.async {
                    self.contactsArray = decoded.results
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedContactsArray.count
        } else {
            return contactsArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        let contact = contactsArray[indexPath.row]
        let image = imagesArray[indexPath.row]

        cell.textLabel?.text = "\(contact.name.first) \(contact.name.last)"

        cell.imageView?.image = image
        cell.imageView?.layer.cornerRadius = 22
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactsArray[indexPath.row]
        let detailedView = DetailedViewController(for: contact)
        navigationController?.pushViewController(detailedView, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedContactsArray = contactsArray.filter({$0.name.first == searchText})
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
}





