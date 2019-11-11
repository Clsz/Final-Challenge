//
//  RegisterViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController:BaseViewController{
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    @IBAction func eyeTapped(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        validateFields()
    }
    
    func setupView() {
        loginButton.loginRound()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func validateFields() {
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return self.showAlert(title: "Error", message: "Email belum diisi")
        }else if emailTF.text?.isValidEmail() == false{
            return self.showAlert(title: "Error", message: "Format email salah")
        }else if passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return self.showAlert(title: "Error", message: "Password belum diisi")
        }else {
            login()
        }
    }
    
    func login() {
        self.showLoading()
        
        let mail = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: mail, password: pass) { (result, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.dismiss(animated: false) {
                        self.showAlert(title: "Error", message: "Email dan Password salah")
                    }
                }
            }else {
                //Dashboard Segue
                DispatchQueue.main.async {
                    self.dismiss(animated: false, completion: nil)
                    print("Loggedin")
                    let destVC = LanguageViewController()
                    self.navigationController?.pushViewController(destVC, animated: true)
                }
            }
        }
    }
    
}
