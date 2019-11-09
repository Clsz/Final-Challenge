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
        
    }
    
    func login() {
        self.showLoading()
        
        let mail = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: mail, password: pass) { (result, error) in
            if error != nil {
                self.showAlert(title: "Perhatian", message: error!.localizedDescription)
            }else {
                //Dashboard Segue
                print("Loggedin")
            }
        }
    }
    
}
