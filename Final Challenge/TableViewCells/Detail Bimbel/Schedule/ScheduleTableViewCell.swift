//
//  ScheduleTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var scheduleTitle: UILabel!
    @IBOutlet weak var scheduleTV: UITableView!
    var homeDelegate:HomeProtocol?
    var course:Courses!
    
    func setView(title:String) {
        self.scheduleTitle.text = title
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
