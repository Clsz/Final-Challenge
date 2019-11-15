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
    var tutor:Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Personal")
    }

}

extension EditProfileViewController:editPassword{
    func changePassword() {
        print("asd")
        let destVC = EditPasswordViewController()
        destVC.oldPasswordTF.text = tutor.password
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
        cell.setView(name: fullName, age: tutor.tutorBirthDate, address: tutor.tutorAddress)
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
