//
//  WaitingConformationViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class WaitingConformationViewController: BaseViewController {
    @IBOutlet weak var waitingTV: UITableView!
    
    var dataArray:[Any?] = []
    var activity:Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.waitingTV.contentInsetAdjustmentBehavior = .never
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {})
        setupView(text: "Detail Pekerjaan")
    }
    
    
    
    
}

extension WaitingConformationViewController{
    func setupData() {
        dataArray.removeAll()
        dataArray.append(activity)
        dataArray.append(("Address",activity.courseAddress,0))
        dataArray.append(("Subject Category",activity.courseCategory))
        dataArray.append(("Grade",activity.courseGrade))
        dataArray.append(("Range Salary","Rp \(String(describing: activity.courseMinFare!.formattedWithSeparator)) - Rp \(String(describing: activity.courseMaxFare!.formattedWithSeparator))",1))
        dataArray.append(("Schedule",activity.courseWorkTime,activity.courseWorkSchedule))
        dataArray.append(("Qualification",activity.courseWorkQualification,0))
        dataArray.append(("Terima Lowongan Kerja","Tolak Lowongan Kerja",true))
    }
    
}
extension WaitingConformationViewController:ActivityProcess{
    func accept() {
        let refreshAlert = UIAlertController(title: "Terima Lowongan Kerja", message: "Apakah Anda Yakin Untuk Menerima Lowongan Kerja Ini", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            let destVC = ResultViewController()
            destVC.fromID = 3
            self.navigationController?.pushViewController(destVC, animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func reject() {
        let refreshAlert = UIAlertController(title: "Tolak Lowongan Kerja", message: "Apakah Anda Yakin Untuk Menolak Lowongan Kerja Ini", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            let destVC = ResultViewController()
            destVC.fromID = 5
            self.navigationController?.pushViewController(destVC, animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}
extension WaitingConformationViewController: UITableViewDataSource,UITableViewDelegate{
    func cellDelegate(){
        waitingTV.dataSource = self
        waitingTV.delegate = self
    }
    
    func registerCell() {
        waitingTV.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        waitingTV.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        waitingTV.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        waitingTV.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        waitingTV.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        waitingTV.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
        waitingTV.register(UINib(nibName: "FooterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterActivityTableViewCellID")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            if let course = dataArray[indexPath.row] as? Activity {
                print(indexPath.row)
                cell.setView(image: course.courseImage, name: course.courseName, lokasi: course.activityStatus)
                cell.lokasiBimbel.textColor = #colorLiteral(red: 0, green: 0.8650887609, blue: 0.320767343, alpha: 1)
            }
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
                print("keyVAlue\(keyValue.value)")
                cell.setView(title: keyValue.key, description: keyValue.value)
                return cell
            }
            else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "salaryCell", for: indexPath) as! SalaryTableViewCell
                cell.setView(title: keyValue.key, salary: keyValue.value)
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:[String]){
            let cell = tableView.dequeueReusableCell(withIdentifier: "subjekCell", for: indexPath) as! SubjectCategoryTableViewCell
            cell.setView(title: keyValue.key)
            cell.subject = keyValue.value
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:[String], desc:[String]){
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
            cell.setView(title: keyValue.key)
            cell.day = keyValue.value
//            cell.schedule = keyValue.desc
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (acc:String, rej:String, _ :Bool){
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterActivityTableViewCellID", for: indexPath) as! FooterActivityTableViewCell
            cell.footerDelegate = self
            cell.setCell(accept: keyValue.acc, reject: keyValue.rej)
            return cell
        }
        return UITableViewCell()
    }
}

