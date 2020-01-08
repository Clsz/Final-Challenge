//
//  SummarySetupBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 16/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SummarySetupBimbelViewController: BaseViewController{
    @IBOutlet weak var tableView: UITableView!
    let headerID = "TitleTableViewCellID"
    let addressID = "DetailAddressTableViewCellID"
    let subjectID = "ContentTableViewCellID"
    let gradesID = "AnotherContentTableViewCellID"
    let logoutView = "LogoutTableViewCellID"
    var dataArray:[Any?] = []
    var course:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        setupData()
        setupView(text: "Course Profile")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Bimbel Profile")
    }
    
    
    
}
extension SummarySetupBimbelViewController{
    
    private func setupData() {
        dataArray.removeAll()
        dataArray.append(course)
        let address = course?.value(forKey: "courseAddress") as? String
        dataArray.append(("Address","Edit Personal",address))
        let subjek = (course?.value(forKey: "courseSubject") as! [String])
        dataArray.append(("Teaching Subjects","Edit Subjects",subjek))
        dataArray.append(("Teaching Grades","Edit Grades",0))
        dataArray.append(true)
    }
}
extension SummarySetupBimbelViewController:confirmProtocol{
    func confirmTapped() {
        let vc = TabBarBimbelController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
    }
}

extension SummarySetupBimbelViewController: UITableViewDataSource, UITableViewDelegate{
    func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: headerID)
        tableView.register(UINib(nibName: "DetailAddressTableViewCell", bundle: nil), forCellReuseIdentifier: addressID)
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: subjectID)
        tableView.register(UINib(nibName: "AnotherContentTableViewCell", bundle: nil), forCellReuseIdentifier: gradesID)
        tableView.register(UINib(nibName: "LogoutTableViewCell", bundle: nil), forCellReuseIdentifier: logoutView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            // FOR HEADER
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID, for: indexPath) as! TitleTableViewCell
            
            let image = UIImage(named: "school")!
            let name = course?.value(forKey: "courseName") as! String
            let operationHour = "\(course?.value(forKey: "courseStartHour") as! String) - \(course?.value(forKey: "courseEndHour") as! String)"
            
            cell.setCell(image: image, name: name, university: operationHour, age: 0)
            cell.hintLabel.text = "ALL INFORMATION ABOUT YOUR BIMBEL"
            cell.ageLabel.isHidden = true
            cell.pencil.isHidden = true
            return cell
        } else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, content:String){
            // FOR ADDRESS
            let cell = tableView.dequeueReusableCell(withIdentifier: addressID, for: indexPath) as! DetailAddressTableViewCell
            
            cell.setCell(keyValue.key, keyValue.value)
            cell.textField.text = keyValue.content
            cell.textField.setBorderBlue()
            cell.textField.outerRound()
            
            return cell
            
        } else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, content:[String]){
            // FOR SUBJECTS
            let cell = tableView.dequeueReusableCell(withIdentifier: subjectID, for: indexPath) as! ContentTableViewCell
            
            cell.setCell(title: keyValue.key, button: keyValue.value)
            //            cell.tutorDelegate =  self
            cell.index = 0
            cell.skills = keyValue.content
            return cell
        } else if let keyValue = dataArray[indexPath.row] as? (key:String, button:String, value:Int){
            if keyValue.value == 0{
                // FOR GRADES
                let cell = tableView.dequeueReusableCell(withIdentifier: gradesID, for: indexPath) as! AnotherContentTableViewCell
                let subjek = course?.value(forKey: "courseGrade") as! [String]
                cell.index = 2
                cell.content = subjek
                cell.setCell(text: keyValue.key, button: keyValue.button)
                //                cell.contentDelegate = self
                
                return cell
                
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
            cell.setInterface()
            cell.index = 1
            cell.logoutButton.titleLabel?.text = "Confirm Profile"
            cell.confirmDelegate = self
            
            return cell
        }
        return UITableViewCell()
    }
    
}
