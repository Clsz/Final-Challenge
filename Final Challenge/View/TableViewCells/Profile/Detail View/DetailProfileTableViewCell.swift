//
//  DetailProfileTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 10/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailProfileTableViewCell: UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var view: UIView!
    var content:String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton()
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
extension DetailProfileTableViewCell:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Selesai", style: .done, target: self, action: #selector(self.donePressed))
        
        
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        
        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.textField.inputAccessoryView = accessoryToolBar
        
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}

