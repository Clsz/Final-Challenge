//
//  TitleTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var pencil: UIButton!
    @IBOutlet weak var outerProfile: UIView!
    var contentDelegate:SGProtocol?
    
    func setView(image:String, name:String, university:String, age:Int) {
        self.outerProfile.outerRound()
        self.profileImage.setRounded()
        self.nameLabel.text = name
        self.universityLabel.text = university
        self.ageLabel.text = String(age)
    }
    
    @IBAction func pencilTapped(_ sender: Any) {
        contentDelegate?.pencilTapped()
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
