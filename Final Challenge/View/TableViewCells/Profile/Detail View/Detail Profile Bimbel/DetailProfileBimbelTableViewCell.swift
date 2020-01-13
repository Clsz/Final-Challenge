//
//  DetailProfileBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailProfileBimbelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var provinceButton: UIButton!
    @IBOutlet weak var provinceTF: UITextField!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextView!
    @IBOutlet weak var startTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    var toolBar = UIToolbar()
    var passwordDelegate:PasswordProtocol?
    var delegate:ProfileBimbelDetailProtocol?
    var addressDelegate:AddressProtocol?
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
    
    @IBAction func changePictureTapped(_ sender: Any) {
        delegate?.imageTapped()
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
    
    @IBAction func cityTapped(_ sender: UIButton) {
        addressDelegate?.cityTapped()
    }
    
    @IBAction func provinceTapped(_ sender: Any) {
        addressDelegate?.provinceTapped()
    }
    
}
extension DetailProfileBimbelTableViewCell{
    func setCell(nameText:String, addressText:String, start:String, end:String, city:String, province:String) {
        self.nameTF.text = nameText
        self.addressTF.text = addressText
        self.startTF.text = start
        self.endTF.text = end
        self.cityTF.text = city
        self.provinceTF.text = province
        
        setInterface()
    }
    
    func setInterface() {
        //LOGIN ROUND
        self.applyButton.loginRound()
        self.cityButton.loginRound()
        self.provinceButton.loginRound()
        self.startButton.loginRound()
        self.endButton.loginRound()
        self.changePasswordButton.loginRound()
        //OUTER ROUND
        self.cityTF.outerRound()
        self.provinceTF.outerRound()
        self.startTF.outerRound()
        self.endTF.outerRound()
        self.nameTF.outerRound()
        self.addressTF.outerRound()
        //SET BORDER
        self.startTF.setBorderBlue()
        self.endTF.setBorderBlue()
        self.nameTF.setBorderBlue()
        self.addressTF.setBorderBlue()
        self.cityTF.setBorderBlue()
        self.provinceTF.setBorderBlue()
        //SET IMAGE
        self.profileImage.setRounded()
        //SET PADDING
        self.nameTF.setLeftPaddingPoints(10.0)
        self.startTF.setLeftPaddingPoints(10.0)
        self.endTF.setLeftPaddingPoints(10.0)
        self.cityTF.setLeftPaddingPoints(10.0)
        self.provinceTF.setLeftPaddingPoints(10.0)
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
