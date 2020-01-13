//
//  LogoutTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 16/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    @IBOutlet weak var logoutButton: UIButton!
    var contentDelegate:ProfileProtocol?
    var confirmDelegate:confirmProtocol?
    var bimbelDelegate:BimbelProtocol?
    var index:Int?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        if index == 0 {
            contentDelegate?.logout()
        } else if index == 1{
            bimbelDelegate?.logout()
        } else {
            confirmDelegate?.confirmTapped()
        }
        
    }
    
}
extension LogoutTableViewCell{
    func setInterface() {
        logoutButton.loginRound()
    }
    
    func setInterfaceLogOut() {
        logoutButton.loginRound()
        logoutButton.setBorderRed()
        logoutButton.setTitleColor(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), for: .normal)
        logoutButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
}
