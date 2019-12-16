//
//  HeaderTestTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class HeaderTestTableViewCell: UITableViewCell {

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
extension HeaderTestTableViewCell{
    func setCell(text:String) {
        self.label.text = text
    }
}
