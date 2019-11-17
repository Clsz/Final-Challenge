//
//  DetailProfileTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 10/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailProfileTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    var content:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension DetailProfileTableViewCell{
    func setCell(text:String, content:String) {
        self.label.text = text
        self.textField.placeholder = content
        
        setInterface()
    }
    
    private func setInterface() {
        self.textField.outerRound()
        self.textField.setLeftPaddingPoints(10.0)
    }
    
}
