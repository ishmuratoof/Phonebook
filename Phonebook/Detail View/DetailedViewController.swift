//
//  DetailedViewController.swift
//  Phonebook
//
//  Created by Камиль on 18.01.2022.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var callButton: UIButton!
    @IBOutlet var messageButton: UIButton!
    
    var detailedContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailedContact = detailedContact else {
            return
        }
        
        let imageUrl = URL(string: detailedContact.picture.large)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        
        nameLabel.text = "\(detailedContact.name.first) \(detailedContact.name.last)"
        numberLabel.text = detailedContact.phone
        emailLabel.text = detailedContact.email
        imageView.image = image
        callButton.setTitle("Call: \(detailedContact.phone)", for: .normal)
        messageButton.setTitle("Email: \(detailedContact.email)", for: .normal)
    }
}
