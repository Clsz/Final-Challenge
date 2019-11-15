//
//  MoreDetailTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class MoreDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    
    func setView(startText:String, endText:String, buttStart:String, buttEnd:String) {
        self.startLabel.text = startText
        self.endLabel.text = endText
        self.startButton.setTitle(buttStart, for: .normal)
        self.endButton.setTitle(buttEnd, for: .normal)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        
    }
    
    @IBAction func endTapped(_ sender: Any) {
        
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
