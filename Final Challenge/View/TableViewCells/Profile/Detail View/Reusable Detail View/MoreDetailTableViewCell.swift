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
    @IBOutlet weak var startTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    var id:Int?
    var dateDelegate:ExperienceProtocol?
    var educationDelegate:EducationProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func startTapped(_ sender: Any) {
        dateDelegate?.startTapped()
        educationDelegate?.startTapped()
    }
    
    @IBAction func endTapped(_ sender: Any) {
        dateDelegate?.endTapped()
        educationDelegate?.endTapped()
    }
    
}
extension MoreDetailTableViewCell{
    func setCell(startText:String, endText:String, buttStart:String, buttEnd:String) {
        self.startLabel.text = startText
        self.endLabel.text = endText
        
        setInterface()
    }
    
    private func setInterface() {
        self.startButton.loginRound()
        self.endButton.loginRound()
        self.startTF.outerRound()
        self.endTF.outerRound()
        
        self.startTF.setLeftPaddingPoints(10.0)
        self.endTF.setLeftPaddingPoints(10.0)
    }
    
}
