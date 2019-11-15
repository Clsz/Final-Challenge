//
//  EditPasswordViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class EditPasswordViewController: BaseViewController {

    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    var oldPassword:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTerm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Change Password"
    }

    @IBAction func applyTapped(_ sender: Any) {
        
    }
}

extension EditPasswordViewController{
    func setTerm() {
        oldPasswordTF.text = oldPassword
        
        oldPasswordTF.outerRound()
        newPasswordTF.outerRound()
    }
}
