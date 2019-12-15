//
//  AddTestButtonTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AddTestButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    var delegate:AddInterviewSchedule?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.addScheduleTapped()
    }
    
}
extension AddTestButtonTableViewCell{
    func setInterface() {
        self.button.loginRound()
    }
}
