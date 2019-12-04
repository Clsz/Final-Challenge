//
//  DetailProfileBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailProfileBimbelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var startTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var outerStart: UIView!
    @IBOutlet weak var outerEnd: UIView!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    var toolBar = UIToolbar()
    var passwordDelegate:PasswordProtocol?
    var delegate:ProfileBimbelDetailProtocol?
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
    
    @IBAction func startTapped(_ sender: Any) {
        delegate?.startTapped()
    }
    
    
    @IBAction func endTapped(_ sender: Any) {
        delegate?.endTapped()
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        passwordDelegate?.changePassword()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        delegate?.applyProfileBimbel()
    }
    
}
extension DetailProfileBimbelTableViewCell{
    func setCell(nameText:String, addressText:String, start:String, end:String) {
        self.nameTF.text = nameText
        self.addressTF.text = addressText
        self.startTF.text = start
        self.endTF.text = end
        
        setInterface()
    }
    
    func setInterface() {
        self.profileImage.setRounded()
        self.changePasswordButton.loginRound()
        self.applyButton.loginRound()
        self.nameTF.layer.borderWidth = 1.0
        self.addressTF.layer.borderWidth = 1.0
        self.startTF.layer.borderWidth = 1.0
        self.endTF.layer.borderWidth = 1.0
        self.nameTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.addressTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.startTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.endTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.startTF.setLeftPaddingPoints(10.0)
        self.endTF.setLeftPaddingPoints(10.0)
        self.nameTF.outerRound()
        self.addressTF.outerRound()
        self.startTF.outerRound()
        self.endTF.outerRound()
    }
    
}
extension DetailProfileBimbelTableViewCell:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
        
        
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        
        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.nameTF.inputAccessoryView = accessoryToolBar
        self.addressTF.inputAccessoryView = accessoryToolBar
        self.startTF.inputAccessoryView  = accessoryToolBar
        self.endTF.inputAccessoryView = accessoryToolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}
