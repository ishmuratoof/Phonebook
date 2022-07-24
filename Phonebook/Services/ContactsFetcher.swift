//
//  ContactsFetcher.swift
//  Phonebook
//
//  Created by Камиль on 23.07.2022.
//

import UIKit

final class ContactsFetcher {
    private var contactsArray = [Contact]()
    private var searchedContactsArray = [Contact]()
    private var isSearching = false
    private var imagesArray = [UIImage?]()

    func getContacts() {
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
                }
            }
        }
    }
}
