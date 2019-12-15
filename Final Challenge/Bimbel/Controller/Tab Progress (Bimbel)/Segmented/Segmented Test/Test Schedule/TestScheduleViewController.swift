//
//  TestScheduleViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class TestScheduleViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var tutorReference:CKRecord.Reference!
    var jobStatus:String?
    var tutor:CKRecord?
    var applicant:CKRecord?
    var day:[String] = []
    var time:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTutor()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Applicant Profile")
    }
    
}
extension TestScheduleViewController{
    private func setupWithoutSchedule() {
        dataArray.removeAll()
        dataArray.append("ALL INFORMATION ABOUT YOUR APPLICANT")
        dataArray.append(tutor)
        dataArray.append(true)
        dataArray.append(("Interview Schedule",0))
        dataArray.append(("AddButton",1))
        dataArray.append(false)
    }
    
    private func setupDataWithSchedule() {
        dataArray.removeAll()
        dataArray.append("ALL INFORMATION ABOUT YOUR APPLICANT")
        dataArray.append(tutor)
        dataArray.append(true)
        dataArray.append(("Interview Schedule",0))
        dataArray.append(("List Schedule",-1))
        dataArray.append(("AddButton",1))
        dataArray.append(false)
    }
    
    private func queryTutor() {
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: tutorReference.recordID.recordName))
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tutor = record[0]
            DispatchQueue.main.async {
                if applicant?.value(forKey: "")
                
                self.setupWithoutSchedule()
                self.cellDelegate()
                self.tableView.reloadData()
            }
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
    
}
extension TestScheduleViewController:JobDetail{
    func seeDetailTapped() {
        let destVC = SeeDetailApplicantViewController()
        destVC.tutor = self.tutor
        destVC.jobStatus = self.jobStatus
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension TestScheduleViewController:UITableViewDataSource, UITableViewDelegate{
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: "HintTableViewCellID")
        tableView.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        tableView.register(UINib(nibName: "SeeDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SeeDetailTableViewCellID")
        tableView.register(UINib(nibName: "HeaderTestTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTestTableViewCellID")
        tableView.register(UINib(nibName: "ContentTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTestTableViewCellID")
        tableView.register(UINib(nibName: "AddTestButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTestButtonTableViewCellID")
        tableView.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HintTableViewCellID", for: indexPath) as! HintTableViewCell
            cell.setCell(text: "ALL INFORMATION ABOUT TEACHER CANDIDATE")
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            let name = (tutor?.value(forKey: "tutorFirstName") as! String) + " " + (tutor?.value(forKey: "tutorLastName") as! String)
            let age = tutor?.value(forKey: "tutorBirthDate") as! Date
            let status = ("Status: " + (jobStatus ?? ""))
            cell.setView(image: "school", name: name, jam: age.toYear(), status: status)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:Int){
            if keyValue.value == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTestTableViewCellID", for: indexPath) as! HeaderTestTableViewCell
                cell.setCell(text: "Interview Schedule")
                return cell
            }else if keyValue.value == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddTestButtonTableViewCellID", for: indexPath) as! AddTestButtonTableViewCell
                cell.setInterface()
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTestTableViewCellID", for: indexPath) as! ContentTestTableViewCell
                //Set day
                //Set title
                //set time
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? Bool{
            if keyValue == true{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeeDetailTableViewCellID", for: indexPath) as! SeeDetailTableViewCell
                cell.jobDetailDelegate = self
                cell.setCell(titleButton: "See Teacher Profile")
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
                cell.setCell(button: "Submit")
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
