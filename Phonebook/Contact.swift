//
//  Contact.swift
//  Phonebook
//
//  Created by Камиль on 04.10.2021.
//

import Foundation

// Defining a struct to store a contact's details

struct Contact: Codable {
    var name: String
    var surname: String
    var phone: String
    var email: String
    var detailPicture: String
    var previewPicture: String
}
