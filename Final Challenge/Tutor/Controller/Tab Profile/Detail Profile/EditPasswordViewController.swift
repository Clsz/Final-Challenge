//
//  EditPasswordViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class EditPasswordViewController: BaseViewController {
    
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var errorText: UILabel!
    var passwordDelegate:PasswordProtocol?
    var delegate:ProfileDetailProtocol?
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        doneButton()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Change Password")
        setMainInterface()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        validatePassword()
    }
}

extension EditPasswordViewController{
    private func setMainInterface() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.oldPasswordTF.setLeftPaddingPoints(10.0)
        self.newPasswordTF.setLeftPaddingPoints(10.0)
        self.confirmTF.setLeftPaddingPoints(10.0)
        
        self.oldPasswordTF.outerRound()
        self.newPasswordTF.outerRound()
        self.confirmTF.outerRound()
        self.applyButton.loginRound()
    }
    
    private func validatePassword() {
        if newPasswordTF.text?.isValidPassword() == false{
            errorText.textColor = .systemRed
            return errorText.text = "Password must contain 6 characters. Combination of uppercase letter, lowercase letter, and number."
        }else if newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return errorText.text = "Please fill the new password."
        }else if confirmTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return errorText.text = "Please fill the Confirmation Password."
        }else if newPasswordTF.text != confirmTF.text{
            errorText.textColor = .systemRed
            return errorText.text = "The Confirmation Password does not match."
        }else if oldPasswordTF.text != (tutors?.value(forKey: "tutorPassword") as! String){
            errorText.textColor = .systemRed
            return errorText.text = "The Old Password is wrong."
        }else{
            errorText.isHidden = true
            getDataCustomCell()
        }
    }
    
    private func getDataCustomCell() {
        self.updateUser(password: newPasswordTF.text ?? "")
       }
       
       func updateUser(password:String){
           if let record = tutors{
               record["tutorPassword"] = password
           
               self.database.save(record, completionHandler: {returnRecord, error in
                   if error != nil
                   {
                       self.showAlert(title: "Error", message: "Update Error")
                   } else{ DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                   }
                    
                   }
               })
           }
       }
}
extension EditPasswordViewController:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.oldPasswordTF.inputAccessoryView = accessoryToolBar
        self.newPasswordTF.inputAccessoryView = accessoryToolBar
        self.confirmTF.inputAccessoryView = accessoryToolBar
        
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}
