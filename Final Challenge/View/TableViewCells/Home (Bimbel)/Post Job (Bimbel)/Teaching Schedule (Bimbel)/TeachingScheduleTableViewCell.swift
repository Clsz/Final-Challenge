//
//  TeachingScheduleTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 13/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TeachingScheduleTableViewCell{
    func setCell(day:String, hour:String) {
        self.labelDay.text = day
        self.labelHour.text = hour
    }
}
