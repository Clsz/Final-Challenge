////
////  BimbelProfileViewController.swift
////  Final Challenge
////
////  Created by Muhammad Reynaldi on 02/12/19.
////  Copyright © 2019 12. All rights reserved.
////
//

import UIKit
import CloudKit
class BimbelProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var course:CKRecord?
    let header = "TitleBimbelTableViewCellID"
    let address = "DetailAddressTableViewCellID"
    let subject = "ContentTableViewCellID"
    let grade = "AnotherContentTableViewCellID"
    let logoutView = "LogoutTableViewCellID"
    var flag = false
    var sendToCustom:SendTutorToCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryDatabase()
        setupView(text: "Bimbel Profile")
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Bimbel Profile")
        setupData()
        registerCell()
        cellDelegate()
    }
    
}
extension BimbelProfileViewController{
    private func setupData() {
        dataArray.removeAll()
        dataArray.append(course)
        dataArray.append(("Address","Edit Address",0))
        dataArray.append(("Teaching Subjects","Add Subjects",1))
        dataArray.append(("Teaching Grades","Edit Grades",2))
        dataArray.append(true)
    }
    
    func queryDatabase() {
        let token = CKUserData.shared.getEmailBimbel()
        let pred = NSPredicate(format: "recordID == %@", token)
        let query = CKQuery(recordType: "Course", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            self.course = records[0]
        }
    }
}
extension BimbelProfileViewController:BimbelProtocol{
    func pencilTapped() {
        let destVC = DetailProfileBimbelViewController()
        destVC.bimbel = self.course
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func addressTapped() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailAddressTableViewCell
        if flag == false{
            flag = true
            cell.textField.isEnabled = true
            cell.button.setTitle("Done", for: .normal)
        }else{
            cell.textField.isEnabled = false
            cell.button.setTitle("Edit Address", for: .normal)
            flag = false
        }
    }
    
    func subjectTapped() {
        let destVC = SubjectViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func gradesTapped() {
        let destVC = SubjectBimbelViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func logout() {
        //Pindah logout
    }
    
}
extension BimbelProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func registerCell() {
        tableView.register(UINib(nibName: "TitleBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: header)
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
    
    //NGE SET CONTENT BERDASARKAN ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            // FOR TITLE
            let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleBimbelTableViewCell
            
            if (course?.value(forKey: "courseName") as? String) != nil {
                let imageDefault = #imageLiteral(resourceName: "user-5")
                let name = course?.value(forKey: "courseName") as! String
                let hourBimbel = "\(course?.value(forKey: "courseStartHour") as! String) - \(course?.value(forKey: "courseEndHour") as! String)"
                
                if course?.value(forKey: "courseImage") != nil{
                    let imageProfile = course?.value(forKey: "courseImage") as! CKAsset
                    cell.setCellBimbel(image: imageProfile.toUIImage()!, name: name, hour: hourBimbel)
                    return cell
                } else {
                    cell.setCellBimbel(image: imageDefault, name: name, hour: hourBimbel)
                    return cell
                }
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            if keyValue.code == 0{
                //FOR ADDRESS
                if (course?.value(forKey: "courseAddress") as? String) != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: address, for: indexPath) as! DetailAddressTableViewCell
                    cell.setCell(keyValue.key, keyValue.value)
                    cell.textField.text = course?.value(forKey: "courseAddress") as? String
                    cell.bimbelDelegate = self
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: address, for: indexPath) as! DetailAddressTableViewCell
                    cell.setCell(keyValue.key, keyValue.value)
                    cell.bimbelDelegate = self
                    return cell
                }
            }else if keyValue.code == 1{
                //FOR SUBJECT
                if (course?.value(forKey: "courseSubject") as? String) != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: subject, for: indexPath) as! ContentTableViewCell
                    cell.setCell(title: keyValue.key, button: keyValue.value)
                    cell.bimbelDelegate = self
                    cell.skills = course?.value(forKey: "courseSubject") as? [String]
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: subject, for: indexPath) as! ContentTableViewCell
                    cell.setCell(title: keyValue.key, button: keyValue.value)
                    cell.bimbelDelegate = self
                    return cell
                }
            }else if keyValue.code == 2{
                if (course?.value(forKey: "courseGrade") as? String) != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: grade, for: indexPath) as! AnotherContentTableViewCell
                    cell.setCell(text: keyValue.key, button: keyValue.value)
                    cell.bimbelDelegate = self
                    cell.destIndex = 3
                    cell.index = 2
                    cell.title = course?.value(forKey: "courseGrade") as? [String]
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: grade, for: indexPath) as! AnotherContentTableViewCell
                    cell.setCell(text: keyValue.key, button: keyValue.value)
                    cell.bimbelDelegate = self
                    return cell
                }
                
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
            cell.setInterface()
            return cell
        }
        return UITableViewCell()
    }
    
}
