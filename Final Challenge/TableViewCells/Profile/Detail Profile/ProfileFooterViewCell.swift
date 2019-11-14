//
//  ProfileFooterViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ProfileFooterViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var button: UIButton!
    
    func setView(text:String) {
        button.titleLabel?.text = text
        button.loginRound()
    }
    @IBAction func applyTapped(_ sender: Any) {
    }
}
