//
//  SetupPersonalViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupPersonalViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    let hint = "HintTableViewCellID"
    let detailProfile = "SetupPersonalTableViewCellID"
    var tutor:Tutor!
    var name:String?
    var age:String?
    var address:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Pengaturan Profil")
    }
}
extension SetupPersonalViewController{
    private func getDataCustomCell() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
        self.name = cell.nameTF.text ?? ""
        self.age = cell.ageTF.text ?? ""
        self.address = cell.addressTF.text ?? ""
    }
}

extension SetupPersonalViewController:ProfileDetailProtocol{
    func applyProfile() {
        getDataCustomCell()
    }
    
}
extension SetupPersonalViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: hint, for: indexPath) as! HintTableViewCell
            cell.setCell(text: "HARAP ATUR PROFIL ANDA")
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! SetupPersonalTableViewCell
            cell.setCell(name: "Masukkan nama kamu", age: "Masukkan umur kamu", address: "Masukkan alamat kamu")
            cell.contentDelegate = self
            return cell
        }
    }
    
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
        tableView.register(UINib(nibName: "SetupPersonalTableViewCell", bundle: nil), forCellReuseIdentifier: detailProfile)
    }

}
