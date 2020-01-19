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
    @IBOutlet weak var addressTF: UITextView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var dobButton: UIButton!
    var contentDelegate:ProfileDetailProtocol?
    var birthDelegate:BirthProtocol?
    var photoDelegate:PhotoProtocol?
    var refreshDelegate:refreshTableProtocol?
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
        photoDelegate?.photoTapped()
    }
    
    
}
extension SetupPersonalTableViewCell{
    func setCell(name:String) {
        self.nameTF.text = name
        
        setInterface()
    }
    
    private func setInterface() {
        self.applyButton.loginRound()
        self.nameTF.outerRound()
        self.ageTF.outerRound()
        self.addressTF.outerRound()
        self.imageProfile.setRounded()
        
        self.nameTF.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.ageTF.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addressTF.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.nameTF.setLeftPaddingPoints(10.0)
        self.ageTF.setLeftPaddingPoints(10.0)
    }
}
extension SetupPersonalTableViewCell:UITextFieldDelegate, UITextViewDelegate{
    private func doneButton() {
        addressTF.delegate = self
        addressTF.text = "Enter your address"
        
        self.accessoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.addressTF.inputAccessoryView = accessoryToolBar
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveTextView(textView, moveDistance: -250, up: true)
            addressTF.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(textView, moveDistance: -250, up: false)
        refreshDelegate?.refreshTableView()
        
        if addressTF.text == "" {
            addressTF.text = "Enter your address"
            addressTF.textColor = UIColor.white
        }
    }
    
    func moveTextView(_ textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    @objc func donePressed() {
//        moveTextField(addressTF, moveDistance: 0, up: true)
        refreshDelegate?.refreshTableView()
        view.endEditing(true)
    }
}
