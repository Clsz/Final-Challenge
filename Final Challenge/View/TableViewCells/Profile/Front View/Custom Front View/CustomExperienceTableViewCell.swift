//
//  CustomExperienceTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class CustomExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func setCell(name:String, place:String, date:String) {
        self.outerView.outerRound()
        self.name.text = name
        self.place.text = place
        self.date.text = date
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
