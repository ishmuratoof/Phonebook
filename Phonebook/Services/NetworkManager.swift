//
//  NetworkManager.swift
//  Phonebook
//
//  Created by Камиль on 23.07.2022.
//

import UIKit

final class NetworkManager {
    static func loadContacts(completion: @escaping ([Contact]) -> Void) {
        let url = URL(string: "https://randomuser.me/api/?results=1000&inc=name,email,phone,picture")!

        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Contacts.self, from: data) {
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            }
        }
    }

    static func loadImage(for string: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageUrl = URL(string: string)!
            let imageData = try! Data(contentsOf: imageUrl)
            let image = UIImage(data: imageData)

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
