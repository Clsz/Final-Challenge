//
//  AnotherContentTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AnotherContentTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showMoreButton: UIButton!
    var contentDelegate:ProfileProtocol?
    var customIndex:Int!
    var tutor:Tutor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if customIndex == 2{
            contentDelegate?.languageTapped()
        }else{
            contentDelegate?.experienceTapped()
        }
    }
    
}
extension AnotherContentTableViewCell{
    func setCell(text:String, button:String) {
        self.label.text = text
        self.button.setTitle(button, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.showMoreButton.loginRound()
    }
}
