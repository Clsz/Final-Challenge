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
        setupView(text: "Ubah Kata Sandi")
        setMainInterface()
    }

    @IBAction func applyTapped(_ sender: Any) {
        validatePassword()
    }
}

extension EditPasswordViewController{
    private func setMainInterface() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.oldPasswordTF.setLeftPaddingPoints(10.0)
        self.newPasswordTF.setLeftPaddingPoints(10.0)

        self.oldPasswordTF.text = oldPassword
        self.oldPasswordTF.outerRound()
        self.newPasswordTF.outerRound()
        self.applyButton.loginRound()
    }
    
    private func getData() {
        tutor = Tutor("01", [], "unknown@gmail.com", newPasswordTF.text ?? "", tutor.tutorFirstName,tutor.tutorLastName, tutor.tutorImage, tutor.tutorPhoneNumber, tutor.tutorAddress, tutor.tutorGender, tutor.tutorBirthDate, [], [], [], [])
        showAlert(title: "Berhasil", message: "Profil anda telah diperbaruhi")
    }
    
    private func validatePassword() {
        if newPasswordTF.text?.isValidPassword() == false{
            return showAlert(title: "Perhatian", message: "Minimum password 6 karakter, minimal 1 huruf besar dan kecil")
        }else if newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return showAlert(title: "Perhatian", message: "Password harus diisi")
        }else{
            showAlert(title: "Berhasil", message: "Password berhasil diganti")
            getData()
        }
    }
}
