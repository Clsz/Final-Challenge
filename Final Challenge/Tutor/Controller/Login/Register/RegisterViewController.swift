//
//  LoginViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

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
    var database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTextField()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func eyeTapped(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func regiterTapped(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RegisterViewController {
    func setupView() {
        registerButton.loginRound()
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func setMainInterface() {
        if firstNameTF.text == "" || lastNameTF.text == "" || emailTF.text == "" || passwordTF.text == ""{
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.6070619822, green: 0.6075353622, blue: 0.6215403676, alpha: 0.8470588235)
        }else{
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0, green: 0.399238348, blue: 0.6880209446, alpha: 1)
        }
    }
    
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
        setMainInterface()
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
    
    func createToken(email:String, completion: @escaping (Bool) -> Void){
        let record = CKRecord(recordType: "Token")
        record["email"] = email
        record["token"] = CKUserData.shared.getDeviceToken()
        
        database.save(record) { (record, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
    func validateFields() {
        textError.textColor = .systemRed
        if emailTF.text?.isValidEmail() == false {
            return textError.text = "Invalid email format"
        }else if passwordTF.text?.isValidPassword() == false {
            return textError.text = "Password must contain 6 characters. Combination of uppercase letter, lowercase letter, and number"
        }else {
            textError.isHidden = true
            self.showLoading()
            let firstName = firstNameTF.text!
            let lastName = lastNameTF.text!
            let email = emailTF.text!
            let password = passwordTF.text!
            CKUserData.shared.loadAllBimbel(email: email, password: password) { (res) in
                if res == true{
                    if CKUserData.shared.checkUser(email: email) == LoginResults.userNotExist {
                        CKUserData.shared.addUser(firstName: firstName, lastName: lastName, email: email, password: password)
                        CKUserData.shared.saveUsers { (user) in
                            self.createToken(email: email) { (success) in
                                DispatchQueue.main.async {
                                    if success{
                                        self.hideLoading()
                                        CKUserData.shared.saveEmail(token: email)
                                        let vc = SetupPersonalViewController()
                                        vc.tutors = user
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        self.hideLoading()
                                        self.showAlert(title: "Attention", message: "User already exist")
                                    }
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoading()
                            self.showAlert(title: "Attention", message: "User already exist")
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.hideLoading()
                }
            }
        }
    }
    
    @objc func donePressed(_ textField: UITextField) {
        moveTextField(textField, moveDistance: 0, up: true)
        view.endEditing(true)
    }
    
}
