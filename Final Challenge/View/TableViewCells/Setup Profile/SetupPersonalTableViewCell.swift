//
//  SetupPersonalTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupPersonalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    var contentDelegate:ProfileDetailProtocol?
    var birthDelegate:BirthProtocol?
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func agePickerTapped(_ sender: UIButton) {
        birthDelegate?.dropBirth()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        contentDelegate?.applyProfile()
    }
    
    @IBAction func photoTapped(_ sender: UIButton) {
    }
    
    
}
extension SetupPersonalTableViewCell{
    func setCell(name:String, age:String, address:String) {
        self.nameTF.placeholder = name
        self.ageTF.placeholder = age
        self.addressTF.placeholder = address
        
        setInterface()
    }
    
    private func setInterface() {
        self.applyButton.loginRound()
        self.nameTF.outerRound()
        self.ageTF.outerRound()
        self.addressTF.outerRound()
        
        self.nameTF.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.ageTF.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addressTF.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.nameTF.setLeftPaddingPoints(10.0)
        self.ageTF.setLeftPaddingPoints(10.0)
        self.addressTF.setLeftPaddingPoints(10.0)
        self.addressTF.contentVerticalAlignment = .top
    }
}
extension SetupPersonalTableViewCell:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
        
        
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        
        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.nameTF.inputAccessoryView = accessoryToolBar
        self.addressTF.inputAccessoryView = accessoryToolBar
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTF.isFirstResponder == true {
            nameTF.placeholder = ""
        }
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}
