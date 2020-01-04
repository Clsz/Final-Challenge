//
//  DetailHeaderTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    var passwordDelegate:PasswordProtocol?
    var delegate:ProfileDetailProtocol?
    var birthDelegate:BirthProtocol?
    var photoDelegate:PhotoProtocol?
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
        
    }
    @IBAction func photoButton(_ sender: UIButton) {
        photoDelegate?.photoTapped()
    }
    
    @IBAction func birthButton(_ sender: UIButton) {
        birthDelegate?.dropBirth()
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        passwordDelegate?.changePassword()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        delegate?.applyProfile()
    }
    
}
extension DetailHeaderTableViewCell{
    func setCell(name:String, age:String, address:String) {
        self.nameTF.text = name
        self.ageTF.text = age
        self.addressTF.text = address
        
        setInterface()
    }
    
    private func setInterface() {
        self.applyButton.loginRound()
        self.changeButton.loginRound()
        self.nameTF.outerRound()
        self.ageTF.outerRound()
        self.addressTF.outerRound()
         self.imageProfile.setRounded()
        
        self.nameTF.setLeftPaddingPoints(10.0)
        self.ageTF.setLeftPaddingPoints(10.0)
        self.addressTF.setLeftPaddingPoints(10.0)
        self.addressTF.contentVerticalAlignment = .top
    }
    
}
extension DetailHeaderTableViewCell:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
        
        
        self.accessoryToolBar.items = [self.accessoryDoneButton]

        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.nameTF.inputAccessoryView = accessoryToolBar
        self.ageTF.inputAccessoryView = accessoryToolBar
        self.addressTF.inputAccessoryView = accessoryToolBar
       
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}
