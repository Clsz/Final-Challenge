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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setView() {
        applyButton.loginRound()
        changeButton.loginRound()
        addressTV.outerRound()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
