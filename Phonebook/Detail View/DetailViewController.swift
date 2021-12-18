//
//  DetailViewController.swift
//  Phonebook
//
//  Created by Камиль on 04.10.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var detailedItem: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailedItem = detailedItem else {
            return
        }

        let imageUrl = URL(string: detailedItem.picture.large)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        
        userName.text = "\(detailedItem.name.first) \(detailedItem.name.last)"
        phone.text = detailedItem.phone
        email.text = detailedItem.email
        userImage.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
