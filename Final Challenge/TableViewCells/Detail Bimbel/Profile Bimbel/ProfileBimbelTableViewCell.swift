//
//  ProfileBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ProfileBimbelTableViewCell: UITableViewCell {

    @IBOutlet weak var imageBimbel: UIImageView!
    @IBOutlet weak var namaBimbel: UILabel!
    @IBOutlet weak var lokasiBimbel: UILabel!
    
    func setView(image:String, name:String, lokasi:String) {
           self.namaBimbel.text = name
           self.lokasiBimbel.text = lokasi
        self.imageBimbel.setRounded()
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
