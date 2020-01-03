//
//  CustomGradesTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 20/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class CustomGradesTableViewCell: UITableViewCell {
    @IBOutlet weak var labelGrade: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CustomGradesTableViewCell{
    func setCell(grade:String) {
        self.outerView.outerRound()
        self.labelGrade.text = grade
    }
}
