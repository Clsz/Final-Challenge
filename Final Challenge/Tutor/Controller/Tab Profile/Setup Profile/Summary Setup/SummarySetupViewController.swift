//
//  SummarySetupViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 13/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SummarySetupViewController: BaseViewController {
    @IBOutlet weak var summaryTV: UITableView!
    var dataArray:[Any?] = []
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var tutors:CKRecord!
    var job:CKRecord!
    var tutor:CKRecord!
    var education:CKRecord!
    var skill:CKRecord!
    var language:CKRecord!
    var experience:CKRecord!
    var tempJobApplicant:[CKRecord.Reference] = []
    var tempUserApplicant:[CKRecord.Reference] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Profile")
    }
    
}
extension SummarySetupViewController{
    private func setupData() {
        dataArray.removeAll()
        dataArray.append(tutor)
        let address = (tutor?.value(forKey: "tutorAddress") as! String)
        dataArray.append(("Address",address,0))
        dataArray.append(("Education",0))
        let skill = (tutor?.value(forKey: "tutorSkills") as! [String])
        dataArray.append(("Skill",skill,1))
        dataArray.append(("Language",2))
        dataArray.append(("Experience",2))
        dataArray.append(("Achievement",3))
        dataArray.append(true)
    }
    
    private func queryEducation() {
        let education = (tutor?.value(forKey: "educationID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: education.recordID.recordName))
        let query = CKQuery(recordType: "Education", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.education = record[0]
            DispatchQueue.main.async {
                
            }
        }
    }
    
    private func queryLanguage() {
        let language = (tutor?.value(forKey: "languageID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: language.recordID.recordName))
        let query = CKQuery(recordType: "Language", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.education = record[0]
            DispatchQueue.main.async {
                
            }
        }
    }
    
    private func queryExperience() {
        let experience = (tutor?.value(forKey: "experienceID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: experience.recordID.recordName))
        let query = CKQuery(recordType: "Experience", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.education = record[0]
            DispatchQueue.main.async {
                
            }
        }
    }
    
}

extension SummarySetupViewController: UITableViewDataSource,UITableViewDelegate{
    private func cellDelegate(){
        summaryTV.dataSource = self
        summaryTV.delegate = self
    }
    
    private func registerCell() {
        summaryTV.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        summaryTV.register(UINib(nibName: "DetailAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailAddressTableViewCellID")
        summaryTV.register(UINib(nibName: "ContentViewTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentViewTableViewCellID")
        summaryTV.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCellID")
        summaryTV.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            let name = (tutors?.value(forKey: "courseName") as! String)
            let workHour = ((tutors?.value(forKey: "courseStartHour") as! String) + " - " + (tutors?.value(forKey: "courseEndHour") as! String))
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
//            cell.contentDelegate = self
            
            return cell
        }
        return UITableViewCell()
    }
}

