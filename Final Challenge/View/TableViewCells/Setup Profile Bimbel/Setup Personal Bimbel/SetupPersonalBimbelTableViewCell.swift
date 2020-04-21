//
//  SetupPersonalBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 16/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupPersonalBimbelTableViewCell: UITableViewCell {
    @IBOutlet weak var imageProfilBimbel: UIImageView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var startTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var provinceTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var buttonProvince: UIButton!
    @IBOutlet weak var buttonCity: UIButton!
    @IBOutlet weak var buttonApply: UIButton!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonEnd: UIButton!
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var view: UIView!
    var contentDelegate:ProfileDetailProtocol?
    var birthDelegate:BirthProtocol?
    var photoDelegate:PhotoProtocol?
    var timeDelegate:BimbelPersonalProtocol?
    var addressDelegate:AddressProtocol?
    var tableDelegate:refreshTableProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInterface()
        doneButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func applyTapped(_ sender: UIButton) {
        contentDelegate?.applyProfile()
    }
    
    @IBAction func endTapped(_ sender: UIButton) {
        timeDelegate?.closeTapped()
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        timeDelegate?.startTapped()
    }
    
    @IBAction func photoTapped(_ sender: UIButton) {
        photoDelegate?.photoTapped()
    }
    
    @IBAction func cityTapped(_ sender: UIButton) {
        addressDelegate?.cityTapped()
    }
    
    @IBAction func provinceTapped(_ sender: UIButton) {
        addressDelegate?.provinceTapped()
    }
    
}
extension SetupPersonalBimbelTableViewCell{
    
    func setInterface() {
        //LOGIN ROUND
        self.buttonApply.loginRound()
        self.buttonStart.loginRound()
        self.buttonEnd.loginRound()
        self.buttonCity.loginRound()
        self.buttonProvince.loginRound()
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
        self.imageProfilBimbel.setRounded()
        //SET PADDING
        self.nameTF.setLeftPaddingPoints(10.0)
        self.addressTF.setLeftPaddingPoints(10.0)
        self.startTF.setLeftPaddingPoints(10.0)
        self.endTF.setLeftPaddingPoints(10.0)
        self.cityTF.setLeftPaddingPoints(10.0)
        self.provinceTF.setLeftPaddingPoints(10.0)
        self.addressTF.contentVerticalAlignment = .top
    }
}
extension SetupPersonalBimbelTableViewCell:UITextFieldDelegate{
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableDelegate?.refreshTableView()
    }
    
    @objc func donePressed() {
        tableDelegate?.refreshTableView()
        view.endEditing(true)
    }
}
