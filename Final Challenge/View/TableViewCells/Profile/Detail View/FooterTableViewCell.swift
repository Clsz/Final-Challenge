//
//  FooterTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 16/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    @IBOutlet weak var applyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
}
extension FooterTableViewCell{
    func setCell(text:String) {
        self.applyButton.setTitle(text, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.applyButton.loginRound()
    }
}
