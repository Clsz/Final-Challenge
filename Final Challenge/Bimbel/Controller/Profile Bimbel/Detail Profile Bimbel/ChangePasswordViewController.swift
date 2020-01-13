//
//  ChangePasswordViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ChangePasswordViewController: BaseViewController {
    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    var course:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Change Password")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        setMainInterface()
        doneButton()
    }

    @IBAction func applyTapped(_ sender: Any) {
        validatePassword()
    }
    
}
extension ChangePasswordViewController{
    private func setMainInterface() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.oldPasswordTF.setLeftPaddingPoints(10.0)
        self.newPasswordTF.setLeftPaddingPoints(10.0)
        self.confirmTF.setLeftPaddingPoints(10.0)
        
        self.oldPasswordTF.layer.borderWidth = 1.0
        self.newPasswordTF.layer.borderWidth = 1.0
        self.confirmTF.layer.borderWidth = 1.0
        self.oldPasswordTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.newPasswordTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.confirmTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
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
        }else if oldPasswordTF.text != (course?.value(forKey: "coursePassword") as! String){
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
           if let record = course{
               record["coursePassword"] = password
               
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
extension ChangePasswordViewController:UITextFieldDelegate{
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

