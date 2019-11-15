//
//  ContentViewTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ContentViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var contentDelegate:SGProtocol?
    
    func setView(text:String, button:String) {
        self.label.text = text
        self.button.setTitle(button, for: .normal)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        contentDelegate?.educationTapped()
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
