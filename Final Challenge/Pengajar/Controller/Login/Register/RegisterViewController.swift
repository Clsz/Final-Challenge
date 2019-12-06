//
//  LoginViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var textError: UILabel!
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTextField()
    }
    
    @IBAction func eyeTapped(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func regiterTapped(_ sender: Any) {
        validateFields()
        
        let firstName = firstNameTF.text!
        let lastName = lastNameTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        let vc = SetupPersonalViewController()
        
        if CKUserData.shared.checkUser(email: email) == LoginResults.userNotExist {
            CKUserData.shared.addUser(firstName: firstName, lastName: lastName, email: email, password: password)
            CKUserData.shared.saveUsers()
            self.navigationController?.pushViewController(vc, animated: false)
        } else { return }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
}

extension RegisterViewController {
    func setupView() {
        registerButton.loginRound()
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    
    func setTextField() {
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        self.accessoryDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        firstNameTF.inputAccessoryView = accessoryToolBar
        lastNameTF.inputAccessoryView = accessoryToolBar
        emailTF.inputAccessoryView = accessoryToolBar
        passwordTF.inputAccessoryView = accessoryToolBar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTF:
            lastNameTF.becomeFirstResponder()
        case lastNameTF:
            emailTF.becomeFirstResponder()
        case emailTF:
            passwordTF.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func validateFields() {
        textError.textColor = .systemRed
        if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return textError.text = "Please enter your first name"
        }else if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return textError.text = "Please enter your email address"
        }else if emailTF.text?.isValidEmail() == false {
            return textError.text = "Invalid format"
        }else if passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return textError.text = "Please enter your password"
        }else if passwordTF.text?.isValidPassword() == false {
            return textError.text = "Password must contain 6 characters. Combination of uppercase letter, lowercase letter, and number"
        }else {
            //                        register()
        }
    }
    
    
    @objc func donePressed(_ textField: UITextField) {
        moveTextField(textField, moveDistance: 0, up: true)
        view.endEditing(true)
    }
    
}
