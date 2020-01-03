//
//  NoAccountTutorTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 26/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class NoAccountTutorTableViewCell: UITableViewCell {

    @IBOutlet weak var setButton: UIButton!
    var delegate:setAccount?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setTapped(_ sender: Any) {
        delegate?.setAccountTapped()
    }
}
extension NoAccountTutorTableViewCell{
    func setInterface() {
        self.setButton.loginRound()
    }
}
