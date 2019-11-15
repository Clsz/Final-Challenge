//
//  CustomLanguageTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class CustomLanguageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var imageLanguage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    
    func setView(name:String, level:String) {
        self.outerView.outerRound()
        self.name.text = name
        self.level.text = level
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
