//
//  JobBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 03/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class JobBimbelTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var postedJobNumber: UILabel!
    @IBOutlet weak var postedTeachingSubjects: UILabel!
    @IBOutlet weak var postedRangeSalary: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension JobBimbelTableViewCell{
    func setCell(number:String, subject:String, salary:String) {
        postedJobNumber.text = number
        postedTeachingSubjects.text = subject
        postedRangeSalary.text = salary
        
        setInterface()
    }
    
    private func setInterface(){
        outerView.outerRound3()
    }
}
