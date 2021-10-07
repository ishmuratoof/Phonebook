//
//  Contact.swift
//  Phonebook
//
//  Created by Камиль on 04.10.2021.
//

import Foundation

// Defining a struct to store a contact's details

struct Contact: Codable {
    var phone: String
    var email: String
//    var names: Name
//    var pictures: Picture
}

//struct Name: Codable {
//    var first: String
//    var second: String
//}
//
//struct Picture: Codable {
//    var large: String
//    var thumbnail: String
//}
