//
//  EditProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let detailProfile = "DetailHeaderTableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Profil")
    }
    
}
extension EditProfileViewController{
    private func getData() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailHeaderTableViewCell
        tutor = Tutor("01", [], "unknown@gmail.com", "rahasia", cell.nameTF.text ?? "","", "", "", cell.addressTF.text ?? "", "", cell.ageTF.text ?? "", [], [], [], [])
        showAlert(title: "Berhasil", message: "Profil anda telah diperbaruhi")
    }
}
extension EditProfileViewController:ProfileDetailProtocol,PasswordProtocol{
    func applyProfile() {
        getData()
    }
    
    func changePassword() {
        let destVC = EditPasswordViewController()
        destVC.oldPassword = tutor.password
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension EditProfileViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! DetailHeaderTableViewCell
        let fullName = tutor.tutorFirstName + " " + tutor.tutorLastName
        cell.setCell(name: fullName, age: tutor.tutorBirthDate, address: tutor.tutorAddress)
        cell.passwordDelegate = self
        cell.delegate = self
        return cell
    }
    
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "DetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: detailProfile)
    }
    
}
