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
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        contentDelegate?.logout()
    }
    
}
extension LogoutTableViewCell{
    func setInterface() {
        logoutButton.loginRound()
    }
    
    
}
