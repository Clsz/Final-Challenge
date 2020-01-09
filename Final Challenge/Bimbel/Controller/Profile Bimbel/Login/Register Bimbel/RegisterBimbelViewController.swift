//
//  RegisterBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 20/12/19.
//  Copyright © 2019 12. All rights reserved.
//
import UIKit
import CloudKit

class RegisterBimbelViewController: BaseViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
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
    @IBAction func eyeTapped(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func backToSignInTapped(_ sender: Any) {
        let loginVC = LoginBimbelViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}


extension RegisterBimbelViewController {
    private func setupView() {
        registerButton.loginRound()
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension RegisterBimbelViewController: UITextFieldDelegate {
    func setTextField() {
        emailTF.delegate = self
        passwordTF.delegate = self
        
        self.accessoryDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
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
        errorLabel.textColor = .systemRed
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return errorLabel.text = "Please enter your email address"
        }else if emailTF.text?.isValidEmail() == false {
            return errorLabel.text = "Invalid email format"
        }else if passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return errorLabel.text = "Please enter your password"
        }else if passwordTF.text?.isValidPassword() == false {
            return errorLabel.text = "Password must contain 6 characters. Combination of uppercase letter, lowercase letter, and number"
        }else {
            errorLabel.isHidden = true
            self.showLoading()
            let email = emailTF.text!
            let password = passwordTF.text!
            CKUserData.shared.loadAllBimbel(email: email, password: password) { (res) in
                if res == true{
                    if CKUserData.shared.checkUser(email: email) == LoginResults.userNotExist {
                        CKUserData.shared.addUserBimbel(email: email, password: password)
                        CKUserData.shared.saveUsersBimbel { (user) in
                            self.createToken(email: email) { (success) in
                                DispatchQueue.main.async {
                                    if success{
                                        self.hideLoading()
                                        CKUserData.shared.saveEmailBimbel(token: email)
                                        let vc = SetupPersonalBimbelViewController()
                                        vc.course = user
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

