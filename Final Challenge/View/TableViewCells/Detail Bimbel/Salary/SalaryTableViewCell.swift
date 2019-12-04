//
//  SalaryTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SalaryTableViewCell: UITableViewCell {

    @IBOutlet weak var salaryTitle: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    var homeDelegate:HomeProtocol?
    var course:Courses!
    
    func setView(title:String, salary:String) {
        self.salaryTitle.text = title
        self.salaryLabel.text = salary
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
