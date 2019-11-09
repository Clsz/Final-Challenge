//
//  LoginViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func eyeTapped(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func regiterTapped(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func setupView() {
        registerButton.loginRound()
    }
    
    func validateFields() {
        if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return self.showAlert(title: "Error", message: "Nama depan belum diisi")
        }else if lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return self.showAlert(title: "Error", message: "Nama Belakang belum diisi")
        }else if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return self.showAlert(title: "Error", message: "Email belum diisi")
        }else if emailTF.text?.isValidEmail() == false {
            return self.showAlert(title: "Error", message: "Format email salah")
        }else if passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return self.showAlert(title: "Error", message: "Password belum diisi")
        }else if passwordTF.text?.isValidPassword() == false {
            return self.showAlert(title: "Perhatian", message: "Password harus berisi 6 karakter 1 huruf kecil dan 1 huruf besar")
        }else {
            register()
        }
    }
    
    func register() {
        self.showLoading()
        
        let firstName = firstNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Error Creating User!!")
                    self.hideLoading()
                }
            } else {
                let db = Firestore.firestore()
                db.collection("Tutor").document(result!.user.uid).setData(["firstName":firstName, "lastName":lastName]) { (error) in
                    
                    if error != nil {
                        print("Error Saving User!!")
                    }
                    
                    DispatchQueue.main.async {
                        self.dismiss(animated: false, completion: nil)
                        //Dashboard segue
                    }
                }
            }
        }
    }
    
}
