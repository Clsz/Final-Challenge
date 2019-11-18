//
//  DetailScheduleTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 18/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setView(day:String, time:String) {
        self.dayLabel.text = day
        self.scheduleLabel.text = time
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
