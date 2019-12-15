//
//  InterviewTestTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class InterviewTestTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var titleTestSchedule: UILabel!
    @IBOutlet weak var daySchedule: UILabel!
    @IBOutlet weak var timeSchedule: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pencilTapped(_ sender: Any) {
        
    }
    
}
extension InterviewTestTableViewCell{
    func setCell(index:Int,day:String, time:String) {
        self.titleTestSchedule.text = "Jadwal Interview \(index+1)"
        self.daySchedule.text = day
        self.timeSchedule.text = "Pukul " + time
        
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
