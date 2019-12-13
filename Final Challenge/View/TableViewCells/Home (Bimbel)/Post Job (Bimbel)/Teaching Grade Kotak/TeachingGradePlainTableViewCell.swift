//
//  TeachingGradePlainTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 13/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingGradePlainTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TeachingGradePlainTableViewCell{
    func setCell(text:String) {
        self.label.text = text
    }
}
