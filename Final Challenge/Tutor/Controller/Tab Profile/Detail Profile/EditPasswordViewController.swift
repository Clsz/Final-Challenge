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
    var passwordDelegate:PasswordProtocol?
    var delegate:ProfileDetailProtocol?
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var oldPassword:String?
    var tutor:Tutor!
    
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
        
        self.oldPasswordTF.outerRound()
        self.newPasswordTF.outerRound()
        self.applyButton.loginRound()
    }
    
    private func getData() {
        tutor = Tutor(tutorID: "01", tutorEducation: [], email: "unknown@gmail.com", password: newPasswordTF.text ?? "", tutorFirstName: tutor.tutorFirstName,tutorLastName: tutor!.tutorLastName, tutorImage: tutor.tutorImage, tutorPhoneNumber: tutor!.tutorPhoneNumber, tutorAddress: tutor.tutorAddress, tutorGender: tutor.tutorGender, tutorBirthDate: tutor.tutorBirthDate, tutorSkills: [], tutorExperience: [], tutorLanguage: [], tutorAchievement: [])
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
extension EditPasswordViewController:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Selesai", style: .done, target: self, action: #selector(self.donePressed))
        
        
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        
        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        self.oldPasswordTF.inputAccessoryView = accessoryToolBar
        self.newPasswordTF.inputAccessoryView = accessoryToolBar
        
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}