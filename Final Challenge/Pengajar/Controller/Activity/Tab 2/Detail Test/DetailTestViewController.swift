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
        self.detailTestTableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Detail Tes")
        detailTestTableView.reloadData()
    }
}

extension DetailTestViewController{
    func setupData() {
        dataArray.removeAll()
        dataArray.append(activity)
        dataArray.append(("Address",activity.courseAddress,0))
        dataArray.append(("Jadwal Test", activity.interviewSchedule, activity.interviewTime, "Silakan pilih salah satu jadwal test diatas", "Perlengkapan Test", activity.testEquipment, "Minta Jadwal Baru"))
        dataArray.append(("Subject Category",activity.courseCategory))
        dataArray.append(("Grade",activity.courseGrade))
        dataArray.append(("Range Salary","Rp \(String(describing: activity.courseMinFare!.formattedWithSeparator)) - Rp \(String(describing: activity.courseMaxFare!.formattedWithSeparator))",1))
        dataArray.append(("Schedule",activity.courseWorkTime,activity.courseWorkSchedule))
        dataArray.append(("Qualification",activity.courseWorkQualification,0))
        dataArray.append(("Terima Tes","Tolak Tes",true))
    }
    
    private func acceptTest() {
        let refreshAlert = UIAlertController(title: "Terima Tes", message: "Apakah Anda Yakin Untuk Menerima Tes Ini", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            let destVC = ResultViewController()
            destVC.fromID = 1
            self.navigationController?.pushViewController(destVC, animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    private func rejectTest() {
        let refreshAlert = UIAlertController(title: "Tolak Tes", message: "Apakah Anda Yakin Untuk Menolak Tes Ini", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ya", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            let destVC = ResultViewController()
            destVC.fromID = 4
            self.navigationController?.pushViewController(destVC, animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Tidak", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}
extension DetailTestViewController:ActivityProcess, ActivityProtocol{
    func requestNewSchedule() {
        let destVC = ResultViewController()
        destVC.fromID = 2
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func accept() {
        acceptTest()
    }
    
    func reject() {
        rejectTest()
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
            if let course = dataArray[indexPath.row] as? Activity {
                print(indexPath.row)
                cell.setView(image: course.courseImage, name: course.courseName, lokasi: "")
            }
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, day:[String], time:[String], hint:String, value:String, equipment:String,  button:String){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCellID", for: indexPath) as! ActivityTableViewCell
            cell.interviewSchedule = keyValue.day
            cell.interviewTime = keyValue.time
            cell.setCell(text: keyValue.key, hint: keyValue.hint, anotherText: keyValue.value, equipment:keyValue.equipment, button: keyValue.button)
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
