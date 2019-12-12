//
//  DetailFinalThirdViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class DetailFinalThirdViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var jobReference:CKRecord.Reference!
    var jobStatus:String?
    var course:CKRecord?
    var job:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryJob()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Job Details")
        self.tableView.reloadData()
    }
    
}
extension DetailFinalThirdViewController{
    private func queryJob() {
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: jobReference.recordID.recordName))
        let query = CKQuery(recordType: "Job", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.job = record[0]
            DispatchQueue.main.async {
                self.queryCourse()
            }
        }
    }
    
    private func queryCourse() {
        let courseID = job?.value(forKey: "courseID") as! CKRecord.Reference
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: courseID.recordID.recordName))
        let query = CKQuery(recordType: "Course", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.course = record[0]
            DispatchQueue.main.async {
                self.setupData()
                self.cellDelegate()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupData() {
        dataArray.removeAll()
        dataArray.append(course)
        let address = (course?.value(forKey: "courseAddress") as! String)
        dataArray.append(("Address",address,0))
        let subject = (job?.value(forKey: "jobSubject") as! [String])
        dataArray.append(("Subject Category", subject))
        let grade = (job?.value(forKey: "jobGrade") as! [String])
        dataArray.append(("Grade", grade))
        let minFare = (job?.value(forKey: "minimumSalary") as! Double)
        let maxFare = (job?.value(forKey: "maximumSalary") as! Double)
        dataArray.append(("Range Salary","Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))",1))
        let scheduleDay = (job?.value(forKey: "jobScheduleDay") as! [String])
        let scheduleStart = (job?.value(forKey: "jobScheduleStart") as! [String])
        let scheduleEnd = (job?.value(forKey: "jobScheduleEnd") as! [String])
        dataArray.append(("Work Schedule",scheduleDay,scheduleStart,scheduleEnd))
        let qualification = (job?.value(forKey: "jobQualification") as! String)
        dataArray.append(("Qualification",qualification,0))
        dataArray.append(true)
    }
    
}
extension DetailFinalThirdViewController: UITableViewDataSource,UITableViewDelegate{
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        tableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        tableView.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        tableView.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        tableView.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            let name = (course?.value(forKey: "courseName") as! String)
            let workHour = ((course?.value(forKey: "courseStartHour") as! String) + " - " + (course?.value(forKey: "courseEndHour") as! String))
            let status = ("Status: " + (jobStatus ?? ""))
            if status == "Accepted"{
                cell.statusBimbel.textColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
            }else{
                cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.3333333333, blue: 0.2980392157, alpha: 1)
            }
            cell.setView(image: "school", name: name, jam: workHour, status: status)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
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
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, day:[String], start:[String], end:[String]){
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
            cell.setView(title: keyValue.key)
            cell.day = keyValue.day
            cell.scheduleStart = keyValue.start
            cell.scheduleEnd = keyValue.end
            return cell
        }
        return UITableViewCell()
    }
}
