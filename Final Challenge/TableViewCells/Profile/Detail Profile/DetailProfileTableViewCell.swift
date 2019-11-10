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
    
    func setCell(text:String, content:String) {
        label.text = text
        textField.text = content
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = ""
            textField.textColor = UIColor.black
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
