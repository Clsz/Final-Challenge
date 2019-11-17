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
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    var delegate:PasswordProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        delegate?.changePassword()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
}
extension DetailHeaderTableViewCell{
    func setCell(name:String, age:String, address:String) {
        self.nameTF.text = name
        self.ageTF.text = age
        self.addressTF.text = address
        
        setInterface()
    }
    
    private func setInterface() {
        self.applyButton.loginRound()
        self.changeButton.loginRound()
        self.nameTF.outerRound()
        self.ageTF.outerRound()
        self.addressTF.outerRound()
        
        self.nameTF.setLeftPaddingPoints(10.0)
        self.ageTF.setLeftPaddingPoints(10.0)
        self.addressTF.setLeftPaddingPoints(10.0)
    }
    
}
