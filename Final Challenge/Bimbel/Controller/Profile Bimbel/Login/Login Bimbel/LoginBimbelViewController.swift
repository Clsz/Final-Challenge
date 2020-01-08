//
//  LoginBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 20/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class LoginBimbelViewController: BaseViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var token:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    @IBAction func registerTapped(_ sender: Any) {
        let vc = RegisterBimbelViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func eyeTapped(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        self.showLoading()
        validateFields()
    }
}

extension LoginBimbelViewController{
    func setupView() {
        loginButton.loginRound()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func loginSucceeded() {
        print ("Login Succeeded")
        
    }
    
    func goToHomeScreen() {
        let vc = TabBarBimbelController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func userNotFound() {
        let alert = UIAlertController(title: "User Not Found", message: "Please Sign Up", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginFailed() {
        print ("Login Failed")
        let alert = UIAlertController(title: "Login Failed", message: "Your Password is incorrect", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func fetchToken(email:String) {
        let pred = NSPredicate(format: "email == %@", email)
        let query = CKQuery(recordType: "Token", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            if record.count > 0{
                self.token = record[0]
                DispatchQueue.main.async {
                    self.updateToken(recordApplicant: self.token!)
                }
            }else{
                DispatchQueue.main.async {
                    self.showAlert(title: "Error Occured", message: "Try again later")
                }
            }
        }
    }
    
    func updateToken(recordApplicant:CKRecord) {
        if let record = token{
            let deviceToken = CKUserData.shared.getDeviceToken()
            record["token"] = deviceToken
            
            self.database.save(record, completionHandler: {returnedRecord, error in
                DispatchQueue.main.async {
                    if error != nil {
                        self.showAlert(title: "Error", message: "Cannot update :(")
                    } else {
                        self.hideLoading()
                        self.goToHomeScreen()
                    }
                }
            })
        }
    }
    
    func validateFields() {
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return self.showAlert(title: "Error", message: "Email belum diisi")
        }else if emailTF.text?.isValidEmail() == false{
            return self.showAlert(title: "Error", message: "Format email salah")
        }else if passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return self.showAlert(title: "Error", message: "Password belum diisi")
        }else {
            let email = emailTF.text!
            let password = passwordTF.text!
            CKUserData.shared.loadUsersBimbel(email: email, password: password) { isSuccess in
                if isSuccess{
                    CKUserData.shared.saveEmailBimbel(token: email)
                    self.fetchToken(email: email)
                }else{
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.showAlert(title: "Attention", message: "User not exist")
                    }
                }
            }
            DispatchQueue.main.async {
                self.hideLoading()
            }
        }
    }
    
}

extension LoginBimbelViewController: UITextFieldDelegate {
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
    
    @objc func donePressed(_ textField: UITextField) {
        moveTextField(textField, moveDistance: 0, up: true)
        view.endEditing(true)
    }
    
}
