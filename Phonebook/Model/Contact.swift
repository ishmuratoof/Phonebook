//
//  Contact.swift
//  Phonebook
//
//  Created by Камиль on 04.12.2021.
//

import Foundation

// Defining structures to store a contact's details

struct Contact: Codable {
    var name: Name
    var email: String
    var phone: String
    var picture: Picture
}
