//
//  SetupPersonalTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupPersonalTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    var contentDelegate:ProfileDetailProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        contentDelegate?.applyProfile()
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        
    }
}
extension SetupPersonalTableViewCell{
    func setCell(name:String, age:String, address:String) {
        self.nameTF.placeholder = name
        self.ageTF.placeholder = age
        self.addressTF.placeholder = address
        
        setInterface()
    }
    
    private func setInterface() {
        self.applyButton.loginRound()
        self.nameTF.outerRound()
        self.ageTF.outerRound()
        self.addressTF.outerRound()
        
        self.nameTF.setLeftPaddingPoints(10.0)
        self.ageTF.setLeftPaddingPoints(10.0)
        self.addressTF.setLeftPaddingPoints(10.0)
        self.addressTF.contentVerticalAlignment = .top
    }
    
}

