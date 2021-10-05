//
//  Contacts.swift
//  Phonebook
//
//  Created by Камиль on 04.10.2021.
//

import Foundation

// Defining a struct to store results from JSON

struct Contacts: Codable {
    var results: [Contact]
}
