//
//  TitleTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var pencil: UIButton!
    @IBOutlet weak var outerProfile: UIView!
    var index:Int?
    var tutorDelegate:ProfileProtocol?
    var bimbelDelegate:BimbelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pencilTapped(_ sender: Any) {
        if index == 0{
            tutorDelegate?.pencilTapped()
        }else{
            bimbelDelegate?.pencilTapped()
        }
    }
    
}
extension TitleTableViewCell{
    func setCell(image:UIImage, name:String, university:String, age:Int) {
        self.nameLabel.text = name
        self.universityLabel.text = university
        self.ageLabel.text = String(age)
        
        setInterface()
    }
    
    func setCellBimbel(image:String, name:String, umur:String, status:String) {
        self.nameLabel.text = name
        self.universityLabel.text = umur
        self.ageLabel.text = status
        pencil.isHidden = true
        setInterface()
        
    }
    
    private func setInterface() {
        self.outerProfile.outerRound()
        self.profileImage.setRounded()
    }
    
}
