//
//  BimbelProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit
class BimbelProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    var bimbel:CKRecord?
    let header = "TitleTableViewCellID"
    let address = "DetailAddressTableViewCellID"
    let subject = "ContentTableViewCellID"
    let grade = "ContentViewTableViewCellID"
    let logoutView = "LogoutTableViewCellID"
    
    var sendToCustom:SendTutorToCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Bimbel Profile")
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        sendToCustom?.sendTutor(tutor: self.tutorModel)
        setupView(text: "Profil")
        setupData()
        registerCell()
        cellDelegate()
    }
    
}
extension BimbelProfileViewController{
    private func setupData() {
        dataArray.removeAll() //Flush
        dataArray.append(bimbel) //0
        dataArray.append(("Address","Edit Address",0)) //0
        dataArray.append(("Teaching Subjects","Add Subjects",1)) //1
        dataArray.append(("Teaching Grades","Edit Grades",2)) //2
        dataArray.append(true) //3
    }
    
    private func addAchievement() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        let file = UIAlertAction(title: "Pilih Dari File", style: .default) { action in
            
            //Select from file
        }
        
        actionSheet.addAction(file)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
}
extension BimbelProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func registerCell() {
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: header)
        tableView.register(UINib(nibName: "DetailAddressTableViewCell", bundle: nil), forCellReuseIdentifier: address)
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: subject)
        tableView.register(UINib(nibName: "ContentViewTableViewCell", bundle: nil), forCellReuseIdentifier: grade)
        tableView.register(UINib(nibName: "LogoutTableViewCell", bundle: nil), forCellReuseIdentifier: logoutView)
    }
    
    private func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleTableViewCell
            if let tutor = dataArray[indexPath.row] as? Tutor {
                let fullName = tutor.tutorFirstName + " " + tutor.tutorLastName
                cell.setCell(image: tutor.tutorImage, name: fullName, university: "Bina Nusantara", age: 22)
                print(fullName)
            }
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! ContentTableViewCell
                cell.setCell(title: keyValue.key, button: keyValue.value)
                return cell
            }else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentView, for: indexPath) as! ContentViewTableViewCell
                cell.setCell(text: keyValue.key, button: keyValue.value)
                return cell
            }else if keyValue.code == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: achievement, for: indexPath) as! AchievementTableViewCell
                cell.setCell(label: keyValue.key, button: keyValue.value)
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String){
            let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
            cell.setCell(text: keyValue.key, button: keyValue.value)
            cell.customIndex = indexPath.row
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
            cell.setInterface()
            return cell
        }
        return UITableViewCell()
    }
    
}
