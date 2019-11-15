//
//  DetailHeaderTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    var delegate:editPassword?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setView(name:String, age:String, address:String) {
        self.nameTF.text = name
        self.ageTF.text = age
        self.addressTV.text = address
        
        self.applyButton.loginRound()
        self.changeButton.loginRound()
        self.addressTV.outerRound()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        print("asd")
        delegate?.changePassword()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
