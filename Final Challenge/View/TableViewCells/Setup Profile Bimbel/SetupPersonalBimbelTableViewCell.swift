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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
}
extension SetupPersonalBimbelTableViewCell{
    func setCell(name:String, address:String) {
        self.nameTF.text = name
        self.addressTF.text = address
        
        setInterface()
    }
    
    private func setInterface() {
        self.buttonApply.loginRound()
        self.buttonStart.loginRound()
        self.buttonEnd.loginRound()
        self.startTF.outerRound()
        self.endTF.outerRound()
        self.startTF.setLeftPaddingPoints(10.0)
        self.endTF.setLeftPaddingPoints(10.0)
        self.startTF.setBorderBlue()
        self.endTF.setBorderBlue()
        self.nameTF.setBorderBlue()
        self.addressTF.setBorderBlue()
        self.nameTF.outerRound()
        self.addressTF.outerRound()
        self.imageProfilBimbel.setRounded()
        
        
        self.nameTF.setLeftPaddingPoints(10.0)
        self.addressTF.setLeftPaddingPoints(10.0)
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
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}
