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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Change Password")
    }

    @IBAction func applyTapped(_ sender: Any) {
        
    }
}

extension EditPasswordViewController{
    private func setMainInterface() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        oldPasswordTF.text = oldPassword
        oldPasswordTF.outerRound()
        newPasswordTF.outerRound()
    }
}
