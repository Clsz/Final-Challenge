//
//  ChangePasswordViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Change Password")
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
        
        self.oldPasswordTF.layer.borderWidth = 1.0
        self.newPasswordTF.layer.borderWidth = 1.0
        self.confirmPasswordTF.layer.borderWidth = 1.0
        self.oldPasswordTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.newPasswordTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.confirmPasswordTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.oldPasswordTF.outerRound()
        self.newPasswordTF.outerRound()
        self.confirmPasswordTF.outerRound()
        self.applyButton.loginRound()
    }
    
    
    private func validatePassword() {
        if newPasswordTF.text?.isValidPassword() == false{
            return showAlert(title: "Attention", message: "Password minimum 6 characters, one uppercase and lowercase")
        }else if newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return showAlert(title: "Attention", message: "Password must be filled")
        }else{
            showAlert(title: "Success", message: "Password must be filled")
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
        self.confirmPasswordTF.inputAccessoryView = accessoryToolBar
        
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}

