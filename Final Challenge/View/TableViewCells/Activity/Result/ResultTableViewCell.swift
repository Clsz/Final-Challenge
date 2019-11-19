//
//  ResultTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var imageResult: UIImageView!
    
    @IBOutlet weak var labelResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonTapped(_ sender: Any) {
    }
    
}
