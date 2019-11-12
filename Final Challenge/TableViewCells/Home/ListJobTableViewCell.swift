//
//  ListJobTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ListJobTableViewCell: UITableViewCell {


    @IBOutlet weak var bimbelPhoto: UIImageView!
    @IBOutlet weak var bimbelName: UILabel!
    @IBOutlet weak var bimbelLocation: UILabel!
    @IBOutlet weak var bimbelSubject: UILabel!
    
    func setView(image:String, name:String, location:String, subject:String) {
        bimbelPhoto.image = UIImage(named: image)
        bimbelName.text = name
        bimbelLocation.text = location
        bimbelSubject.text = subject
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
