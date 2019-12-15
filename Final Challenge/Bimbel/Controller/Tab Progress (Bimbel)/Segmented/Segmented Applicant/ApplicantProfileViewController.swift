//
//  ApplicantProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ApplicantProfileViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var tutorReference:CKRecord.Reference!
    var jobStatus:String?
    var tutor:CKRecord?
    var education:CKRecord?
    var language:CKRecord?
    var experience:CKRecord?
    var applicant:CKRecord?
    var isLoadedEducation:Bool?
    var isLoadedLanguage:Bool?
    var isLoadedExperience:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTutor()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Applicant Profile")
    }
    
}
extension ApplicantProfileViewController{
    private func setupData() {
        dataArray.removeAll()
        dataArray.append("ALL INFORMATION ABOUT YOUR APPLICANT")
        dataArray.append(tutor)
        let address = (tutor?.value(forKey: "tutorAddress") as! String)
        dataArray.append(("Address",address,0))
        dataArray.append(("Education",0))
        let skill = (tutor?.value(forKey: "tutorSkills") as! [String])
        dataArray.append(("Skill",skill,1))
        dataArray.append(("Language",2))
        dataArray.append(("Experience",-1))
        dataArray.append(true)
    }
    
    private func queryTutor() {
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: tutorReference.recordID.recordName))
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tutor = record[0]
            
            DispatchQueue.main.async {
                self.queryEducation()
                self.queryLanguage()
                self.queryExperience()
            }
        }
    }
    
    private func queryEducation() {
        let education = (tutor?.value(forKey: "educationID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: education.recordID.recordName))
        let query = CKQuery(recordType: "Education", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.education = record[0]
            DispatchQueue.main.async {
                self.isLoadedEducation = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func queryLanguage() {
        let language = (tutor?.value(forKey: "languageID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: language.recordID.recordName))
        let query = CKQuery(recordType: "Language", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.language = record[0]
            DispatchQueue.main.async {
                self.isLoadedLanguage = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func queryExperience() {
        let experience = (tutor?.value(forKey: "experienceID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: experience.recordID.recordName))
        let query = CKQuery(recordType: "Experience", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.experience = record[0]
            DispatchQueue.main.async {
                self.isLoadedExperience = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func checkIsLoaded() {
        if isLoadedEducation == true && isLoadedLanguage == true && isLoadedExperience == true{
            self.setupData()
            self.cellDelegate()
            self.tableView.reloadData()
        }
        
    }
    
    private func updateToDatabase(status:String, completion : @escaping (Bool) -> Void) {
        if let record = applicant{
            record["status"] = status
            self.database.save(record, completionHandler: {returnedRecord, error in
                DispatchQueue.main.async {
                    if error != nil {
                        self.showAlert(title: "Error", message: "Cannot update :(")
                    } else {
                        completion(true)
                    }
                }
            })
        }
        
    }
    
    private func acceptAlert() {
        let confirmAlert = UIAlertController(title: "Accept the Teacher?", message: "Are you sure you want to accept this Teacher?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.updateToDatabase(status: "Waiting for Your Test Schedule") { (res) in
                if res == true{
                    let destVC = ResultViewController()
                    destVC.fromID = 1
                    self.navigationController?.pushViewController(destVC, animated: true)
                }
            }
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction!) in }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    private func rejectAlert() {
        let confirmAlert = UIAlertController(title: "Decline the Teacher?", message: "Are you sure you want to decline this Teacher?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.updateToDatabase(status: "Rejected") { (res) in
                if res == true{
                    let destVC = ResultViewController()
                    destVC.fromID = 4
                    self.navigationController?.pushViewController(destVC, animated: true)
                }
            }
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
}
extension ApplicantProfileViewController:ActivityProcess{
    func accept() {
        self.acceptAlert()
    }
    
    func reject() {
        self.rejectAlert()
    }
}
extension ApplicantProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: "HintTableViewCellID")
        tableView.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        tableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        tableView.register(UINib(nibName: "AnotherContentTableViewCell", bundle: nil), forCellReuseIdentifier: "AnotherContentTableViewCellID")
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCellID")
        tableView.register(UINib(nibName: "FooterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterActivityTableViewCellID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HintTableViewCellID", for: indexPath) as! HintTableViewCell
            cell.setCell(text: "ALL INFORMATION ABOUT YOUR APPLICANT")
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            let name = (tutor?.value(forKey: "tutorFirstName") as! String) + " " + (tutor?.value(forKey: "tutorLastName") as! String)
            let age = tutor?.value(forKey: "tutorBirthDate") as! Date
            let status = ("Status: " + (jobStatus ?? ""))
            cell.setView(image: "school", name: name, jam: age.toYear(), status: status)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
            cell.setView(title: keyValue.key, description: keyValue.value)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:[String],code:Int){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCellID", for: indexPath) as! ContentTableViewCell
            cell.index = 0
            cell.setCell(title: keyValue.key, button: "")
            cell.editButton.isHidden = true
            cell.skills = keyValue.value
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:Int){
            if keyValue.value == 0{
                // FOR EDUCATION
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherContentTableViewCellID", for: indexPath) as! AnotherContentTableViewCell
                let schoolName = education?.value(forKey: "schoolName") as! [String]
                let grade = education?.value(forKey: "grade") as! [String]
                let fos = education?.value(forKey: "fieldOfStudy") as! [String]
                cell.index = 0
                cell.title = schoolName
                cell.content = grade
                cell.footer = fos
                //Hide Button
                cell.button.isHidden = true
                cell.setCell(text: "Education", button: "")
                return cell
            }else if keyValue.value == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherContentTableViewCellID", for: indexPath) as! AnotherContentTableViewCell
                let companyName = experience?.value(forKey: "jobCompanyName") as! [String]
                let jobTitle = experience?.value(forKey: "jobTitle") as! [String]
                let startYear = experience?.value(forKey: "jobStartYear") as! [String]
                let endYear = experience?.value(forKey: "jobEndYear") as! [String]
                cell.title = jobTitle
                cell.content = companyName
                cell.startYear = startYear
                cell.endYear = endYear
                cell.index = -1
                //Hide Button
                cell.button.isHidden = true
                cell.setCell(text: keyValue.key, button: "")
                return cell
            }else if keyValue.value == -1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherContentTableViewCellID", for: indexPath) as! AnotherContentTableViewCell
                let lang = language?.value(forKey: "languageName") as! [String]
                let level = language?.value(forKey: "languageLevel") as! [String]
                cell.index = 1
                cell.title = lang
                cell.content = level
                //Hide button
                cell.button.isHidden = true
                cell.setCell(text: keyValue.key, button: "")
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterActivityTableViewCellID", for: indexPath) as! FooterActivityTableViewCell
            cell.setCell(accept: "Accept", reject: "Reject")
            cell.footerDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
}
