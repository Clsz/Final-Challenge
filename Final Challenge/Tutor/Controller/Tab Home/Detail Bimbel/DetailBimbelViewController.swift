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
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var course:CKRecord!
    var job:CKRecord!
    var tutor:CKRecord!
    var tempJobApplicant:[CKRecord.Reference] = []
    var tempUserApplicant:[CKRecord.Reference] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryCourse()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Detail Pekerjaan")
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
    }
    
}
extension DetailBimbelViewController{
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
    
    private func queryUser() {
        let token = CKUserData.shared.getToken()
        
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tutor = record[0]
            DispatchQueue.main.async {
                self.applyJob()
            }
        }
    }
    
    private func applyJob(){
        let record = CKRecord(recordType: "Applicant")
        let fullName = (tutor.value(forKey: "firstName") as! String) + " " + (tutor.value(forKey: "tutorLastName") as! String)
        
        record["courseName"] = course?.value(forKey: "courseName") as! String
        record["tutorName"] = fullName
        record["jobID"] = CKRecord.Reference.init(recordID: job.recordID , action: .deleteSelf)
        record["tutorID"] = CKRecord.Reference.init(recordID: tutor.recordID , action: .deleteSelf)
        record["status"] = "Job Requested"
        
        database.save(record) { (record, error) in
            guard record != nil  else { return print("error", error as Any) }
            self.updateToJob(recordApplicant: record!)
            self.updateToUser(recordApplicant: record!)
        }
    }
    
    private func updateToJob(recordApplicant:CKRecord) {
        if let record = tutor{
            tempJobApplicant = job.value(forKey: "applicantID") as? [CKRecord.Reference] ?? []
            let tempID = CKRecord.Reference.init(recordID: recordApplicant.recordID, action: .deleteSelf)
            tempJobApplicant.append(tempID)
            record["applicantID"] = tempJobApplicant
            
            self.database.save(record, completionHandler: {returnedRecord, error in
                if error != nil {
                    self.showAlert(title: "Error", message: "Cannot update :(")
                } else {
                    
                }
            })
        }
        
    }
    
    private func updateToUser(recordApplicant:CKRecord) {
        if let record = job{
            tempUserApplicant = job.value(forKey: "applicantID") as? [CKRecord.Reference] ?? []
            let tempID = CKRecord.Reference.init(recordID: recordApplicant.recordID, action: .deleteSelf)
            tempUserApplicant.append(tempID)
            record["applicantID"] = tempUserApplicant
            
            self.database.save(record, completionHandler: {returnedRecord, error in
                if error != nil {
                    self.showAlert(title: "Error", message: "Cannot update :(")
                } else {
                    
                }
            })
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
                self.detailBimbelTV.reloadData()
            }
        }
    }
    
}
extension DetailBimbelViewController:DetailBimbel, UpdateConstraint{
    func requestTapped() {
        if CKUserData.shared.getToken() != "" {
            self.queryUser()
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc = TabBarController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.flag = false
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }
        
    }
    
    func updateViewConstraint() {
        viewWillLayoutSubviews()
    }
    
}
extension DetailBimbelViewController: UITableViewDataSource,UITableViewDelegate{
    private func cellDelegate(){
        detailBimbelTV.dataSource = self
        detailBimbelTV.delegate = self
    }
    
    private func registerCell() {
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
            let name = (course?.value(forKey: "courseName") as! String)
            let workHour = ((course?.value(forKey: "courseStartHour") as! String) + " - " + (course?.value(forKey: "courseEndHour") as! String))
            cell.setView(image: "school", name: name, jam: workHour, status: "")
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
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
            cell.contentDelegate = self
            
            return cell
        }
//        if education != nil {
//
//                       } cell.title = [""]
        return UITableViewCell()
    }
}
