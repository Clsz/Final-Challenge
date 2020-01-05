//
//  InterviewBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 04/01/20.
//  Copyright © 2020 12. All rights reserved.
//

import UIKit

class InterviewBimbelTableViewCell: UITableViewCell {
    @IBOutlet weak var labelHari: UILabel!
    @IBOutlet weak var labelWaktu: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pencilTapped(_ sender: UIButton) {
    }
}
extension InterviewBimbelTableViewCell{
    func setCell(day:String, time:String) {
        self.labelHari.text = day
        self.labelWaktu.text = time
        
        setInterface()
    }
    
    private func setInterface() {
        self.outerView.setBorderBlue()
        self.outerView.layer.borderWidth = 4.0
        self.outerView.outerRound()
        self.contentView.setBorder()
        self.contentView.outerRound()
    }
}
