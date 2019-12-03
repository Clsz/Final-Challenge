//
//  SubmitTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SubmitTableViewCell: UITableViewCell {

    @IBOutlet weak var requestButton: UIButton!
    var contentDelegate:DetailBimbel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func requestTapped(_ sender: UIButton) {
        contentDelegate?.requestTapped()
    }
    
}
