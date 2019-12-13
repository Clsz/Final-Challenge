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
    
    var isLoadedEducation:Bool?
    var isLoadedLanguage:Bool?
    var isLoadedExperience:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Applicant Profile")
    }
    
}
extension ApplicantProfileViewController{
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
    
    private func queryTutor() {
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: tutorReference.recordID.recordName))
        let query = CKQuery(recordType: "Job", predicate: pred)
        
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
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: education.recordID.recordName))
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
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: language.recordID.recordName))
        let query = CKQuery(recordType: "Language", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.education = record[0]
            DispatchQueue.main.async {
                self.isLoadedLanguage = true
                self.checkIsLoaded()
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
    
}
extension ApplicantProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            let name = (tutor?.value(forKey: "tutorFirstName") as! String) + " " + (tutor?.value(forKey: "tutorLastName") as! String)
            let age = tutor?.value(forKey: "tutorBirthData") as! Date
            let status = ("Status: " + (jobStatus ?? ""))
            cell.setView(image: "school", name: name, jam: age.toYear(), status: status)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
            cell.setView(title: keyValue.key, description: keyValue.value)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:[String],code:Int){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCellID", for: indexPath) as! ContentTableViewCell
            
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:Int){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherContentTableViewCellID", for: indexPath) as! AnotherContentTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterActivityTableViewCellID", for: indexPath) as! FooterActivityTableViewCell
            cell.setCell(accept: "Accept", reject: "Reject")
            return cell
        }
    }
    
    
}
