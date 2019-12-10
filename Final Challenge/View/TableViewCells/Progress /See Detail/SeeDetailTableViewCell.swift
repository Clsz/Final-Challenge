//
//  SeeDetailTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 07/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SeeDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    var jobDetailDelegate:JobDetail?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func requestNewScheduleTapped(_ sender: Any) {
        jobDetailDelegate?.seeDetailTapped()
    }
    
}
extension SeeDetailTableViewCell{
    func setCell(titleButton:String) {
        self.button.setTitle(titleButton, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.button.loginRound()
    }
}
