//
//  DetailTestViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 18/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailTestViewController: BaseViewController {
    @IBOutlet weak var detailTestTableView: UITableView!
    
    var dataArray:[Any?] = []
    var activity:Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Detail Tes")
    }
}

extension DetailTestViewController{
    func setupData() {
        dataArray.removeAll()
        dataArray.append(activity)
        dataArray.append(("Address",activity.courseAddress,0))
        dataArray.append(("Jadwal Test","Silakan pilih salah satu jadwal test diatas", "Perlengkapan Test", "Minta Jadwal Baru"))
        dataArray.append(("Subject Category",activity.courseCategory))
        dataArray.append(("Grade",activity.courseGrade))
        dataArray.append(("Range Salary","Rp \(String(describing: activity.courseMinFare!)) - Rp \(String(describing: activity.courseMaxFare!))",1))
        dataArray.append(("Schedule",activity.courseWorkTime,activity.courseWorkSchedule))
        dataArray.append(("Qualification",activity.courseWorkQualification,0))
        dataArray.append(("Terima Tes","Tolak Tes",true))
    }
    
}
extension DetailTestViewController:ActivityProcess{
    func accept() {
        let refreshAlert = UIAlertController(title: "Terima Lowongan kerja", message: "Apakah Anda Yakin Untuk Menerima Lowongan Kerja Ini", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
            let destVC = ResultViewController()
            destVC.fromID = 0
            self.navigationController?.pushViewController(destVC, animated: true)
          }))

        refreshAlert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))
        
        

        present(refreshAlert, animated: true, completion: nil)
    }
    
    func reject() {
       let refreshAlert = UIAlertController(title: "Tolak Lowongan kerja", message: "Apakah Anda Yakin Untuk Menolak Lowongan Kerja Ini", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))

        refreshAlert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
}
extension DetailTestViewController: UITableViewDataSource,UITableViewDelegate{
    func cellDelegate(){
        detailTestTableView.dataSource = self
        detailTestTableView.delegate = self
    }
    
    func registerCell() {
        detailTestTableView.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        detailTestTableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        detailTestTableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCellID")
        detailTestTableView.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        detailTestTableView.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        detailTestTableView.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        detailTestTableView.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
        detailTestTableView.register(UINib(nibName: "FooterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterActivityTableViewCellID")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            if let course = dataArray[indexPath.row] as? Courses {
                print(indexPath.row)
                cell.setView(image: course.courseImage, name: course.courseName, lokasi: course.courseLocation)
            }
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, hint:String, value:String, button:String){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCellID", for: indexPath) as! ActivityTableViewCell
            cell.interviewSchedule = activity.interviewSchedule
            cell.interviewTime = activity.interviewTime
            cell.additionTF.text = activity.testEquipment
            cell.setCell(text: keyValue.key, hint: keyValue.hint, anotherText: keyValue.value, button: keyValue.button)
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
            cell.schedule = keyValue.desc
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
