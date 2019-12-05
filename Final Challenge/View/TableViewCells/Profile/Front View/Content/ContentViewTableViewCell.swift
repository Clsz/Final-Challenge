//
//  ContentViewTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ContentViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var id:Int?
    var tutor:CKRecord?
    var education:CKRecord?
    var language:CKRecord?
    var experience:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var contentDelegate:ProfileProtocol?
    let customExperienceTableViewCell = "CustomExperienceTableViewCellID"
    let customLanguageTableViewCell = "CustomLanguageTableViewCellID"
    var tutorCustom:Tutor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()
        cellDelegate()
        tableView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func editTapped(_ sender: Any) {
        contentDelegate?.educationTapped()
    }
    
}
extension ContentViewTableViewCell{
    func setCell(text:String, button:String) {
        self.label.text = text
        self.button.setTitle(button, for: .normal)
    }
    
    func setCell2(text:String) {
        self.label.text = text
        button.isHidden = true
    }
    
    private func requestEducation() {
        let listEducationID = (tutor?.value(forKey: "educationID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: listEducationID.recordID.recordName))
        let query = CKQuery(recordType: "Education", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            let sortedRecords = record.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.education = sortedRecords.first
            DispatchQueue.main.async {
                self.cellDelegate()
                self.tableView.reloadData()
            }
        }
    }
    
    
}

extension ContentViewTableViewCell:SendTutorToCustom{
    func sendTutor(tutor: Tutor) {
        self.tutorCustom = tutor
    }
}
extension ContentViewTableViewCell:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if id == 0{
            return 1
            // Return Education count
        }else if id == 1{
            return 1
            // Return Language Count
        }else{
            return 1
            // Return Experience Count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if id == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: customExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
            let university = (education?.value(forKey: "universityName") as! String)
            let grade = (education?.value(forKey: "grade") as! String)
            let field = (education?.value(forKey: "fieldOfStudy") as! String) + (education?.value(forKey:"GPA") as! String)
            
            cell.setCell(name: university, place: grade, date: "Field of Study: \(field)")
            return cell
        }else if id == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: customLanguageTableViewCell, for: indexPath) as! CustomLanguageTableViewCell
            let languageName = (language?.value(forKey: "languageName") as! String)
            let level = (language?.value(forKey: "languageLevel") as! String)
            cell.setCell(name: languageName, level: level)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: customExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
            let jobTitle = (experience?.value(forKey: "jobName") as! String)
            let company = (experience?.value(forKey: "jobLocation") as! String)
            let time = (experience?.value(forKey: "startDate") as! String) + "-" + (experience?.value(forKey: "endDate") as! String)
            cell.setCell(name: jobTitle, place: company, date: time)
            return cell
        }
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell" , bundle: nil), forCellReuseIdentifier: customExperienceTableViewCell)
        tableView.register(UINib(nibName: "CustomLanguageTableViewCell", bundle: nil), forCellReuseIdentifier: customLanguageTableViewCell)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
