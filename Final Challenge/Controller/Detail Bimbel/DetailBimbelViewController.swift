//
//  DetailBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class DetailBimbelViewController: BaseViewController {
    
    @IBOutlet weak var detailBimbelTV: UITableView!
    var dataArray:[Any?] = []
    var course:CKRecord!
    var schedule:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestSchedule()
        setupData()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Detail Pekerjaan")
        setupData()
    }
    
}
extension DetailBimbelViewController{
    func setupData() {
        dataArray.removeAll()
        dataArray.append(course)
        let address = (course?.value(forKey: "courseAddress") as! String)
        dataArray.append(("Address",address,0))
        let subject = (course?.value(forKey: "courseSubject") as! [String])
        dataArray.append(("Subject Category", subject))
        let grade = (course?.value(forKey: "courseGrade") as! [String])
        dataArray.append(("Grade", grade))
        let minFare = (course?.value(forKey: "courseFareMinimum") as! Double)
        let maxFare = (course?.value(forKey: "courseFareMaximum") as! Double)
        dataArray.append(("Range Salary","Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))",1))
        dataArray.append("Schedule")
        let qualification = (course?.value(forKey: "courseRequirement") as! String)
        dataArray.append(("Qualification",qualification,0))
        dataArray.append(true)
    }
    
    func applyJob(){
        //Get Referemce
        let newApply = CKRecord(recordType: "Activity")
        let reference = CKRecord.Reference(recordID: course.recordID , action: .deleteSelf)
        newApply["courseID"] = reference
        newApply["activityStatus"] = "Waiting Confirmation"

        database.save(newApply) { (record, error) in
            guard record != nil else {
                print("error", error as Any)
                return }
            print("saved request with data")
        }
    }
    
}
extension DetailBimbelViewController:DetailBimbel{
    func requestSchedule() {
        let listScheduleID = (course?.value(forKey: "scheduleID") as! CKRecord.Reference)
        
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: listScheduleID.recordID.recordName))
        let query = CKQuery(recordType: "Schedule", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            let sortedRecords = record.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.schedule = sortedRecords.first
            DispatchQueue.main.async {
                self.cellDelegate()
                self.detailBimbelTV.reloadData()
            }
        }
    }
    
    func requestTapped() {
        applyJob()
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension DetailBimbelViewController: UITableViewDataSource,UITableViewDelegate{
    func cellDelegate(){
        detailBimbelTV.dataSource = self
        detailBimbelTV.delegate = self
    }
    
    func registerCell() {
        detailBimbelTV.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        detailBimbelTV.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        detailBimbelTV.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        detailBimbelTV.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        detailBimbelTV.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        detailBimbelTV.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            cell.setView(image: "school", name: course?.value(forKey: "courseName") as! String, lokasi: course?.value(forKey: "courseAddress") as! String)
            return cell
        }
        else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
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
        }else if let keyValue = dataArray[indexPath.row] as? String{
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
            cell.setView(title: keyValue)
            cell.day = schedule?.value(forKey: "scheduleDay") as! [String]
            cell.scheduleStart = schedule?.value(forKey: "scheduleStart") as! [String]
            cell.scheduleEnd = schedule?.value(forKey: "scheduleEnd") as! [String]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
            cell.contentDelegate = self
            return cell
        }
        return UITableViewCell()
    }
}
