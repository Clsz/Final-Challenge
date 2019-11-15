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
    var contentDelegate:SGProtocol?
    var customIndex:Int!
    
    var tutor:Tutor!
    
    func setView(text:String, button:String) {
        self.label.text = text
        self.button.setTitle(button, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if customIndex == 2{
            contentDelegate?.languageTapped()
        }else{
            contentDelegate?.experienceTapped()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
