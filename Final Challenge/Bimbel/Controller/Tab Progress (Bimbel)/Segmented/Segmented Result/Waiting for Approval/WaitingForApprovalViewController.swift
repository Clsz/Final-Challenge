//
//  WaitingForApprovalViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class WaitingForApprovalViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var tutorReference:CKRecord.Reference!
    var jobStatus:String?
    var tutor:CKRecord?
    var applicant:CKRecord?
    var tokenUser:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTutor()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Applicant Profile")
    }
    
}
extension WaitingForApprovalViewController{
    private func setupData() {
        dataArray.removeAll()
        dataArray.append("ALL INFORMATION ABOUT YOUR APPLICANT")
        dataArray.append(tutor)
        dataArray.append(true)
        dataArray.append(("BlankView",0))
        dataArray.append(false)
    }
    
    private func queryTutor() {
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: tutorReference.recordID.recordName))
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tutor = record[0]
            DispatchQueue.main.async {
                self.fetchToken()
            }
        }
    }
    
    private func fetchToken() {
        let email = (tutor?.value(forKey: "tutorEmail") as! String)
        let pred = NSPredicate(format: "email == %@", email)
        let query = CKQuery(recordType: "Token", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tokenUser = record[0]
            DispatchQueue.main.async {
                self.setupData()
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
    
    private func acceptAlert() {
        let confirmAlert = UIAlertController(title: "Accept the Teacher", message: "Are you sure you want to accept the teacher?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.updateToDatabase(status: "Waiting for Applicant Approval") { (res) in
                if res == true{
                    self.sendNotif(message: "Waiting for Your Last Approval", destID: 1)
                }
            }
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction!) in }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    private func rejectAlert() {
        let confirmAlert = UIAlertController(title: "Reject the Teacher", message: "Are you sure you want to reject the teacher?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.updateToDatabase(status: "Rejected") { (res) in
                if res == true{
                    self.sendNotif(message: "Your Job Has Been Rejected", destID: 4)
                }
            }
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    private func sendNotif(message:String,destID:Int) {
        let token = self.tokenUser?.value(forKey: "token") as! String
        let sender = self.applicant?.value(forKey: "courseName") as! String
        let request = self.applicant?.value(forKey: "tutorID") as! CKRecord.Reference
        let destVC = ResultViewController()
        destVC.fromID = destID
        
        Service.sendNotification(message: "\(message) \(sender))", token: [token], idSender: sender, idRequest: request.recordID.recordName, tabBar: 1) { (error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(destVC, animated: true)

                }
            }
        }
    }
    
}
extension WaitingForApprovalViewController:JobDetail{
    func seeDetailTapped() {
        let destVC = SeeDetailApplicantViewController()
        destVC.tutor = self.tutor
        destVC.jobStatus = self.jobStatus
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension WaitingForApprovalViewController:ActivityProcess{
    func accept() {
        self.acceptAlert()
    }
    
    func reject() {
        self.rejectAlert()
    }
}
extension WaitingForApprovalViewController:UITableViewDataSource, UITableViewDelegate{
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: "HintTableViewCellID")
        tableView.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        tableView.register(UINib(nibName: "SeeDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SeeDetailTableViewCellID")
        tableView.register(UINib(nibName: "BlankViewTableViewCell", bundle: nil), forCellReuseIdentifier: "BlankViewTableViewCellID")
        tableView.register(UINib(nibName: "FooterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterActivityTableViewCellID")
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
        }else if let keyValue = dataArray[indexPath.row] as? Bool{
            if keyValue == true{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeeDetailTableViewCellID", for: indexPath) as! SeeDetailTableViewCell
                cell.jobDetailDelegate = self
                cell.setCell(titleButton: "See Teacher Profile")
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FooterActivityTableViewCellID", for: indexPath) as! FooterActivityTableViewCell
                cell.footerDelegate = self
                cell.setCell(accept: "Accept", reject: "Reject")
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankViewTableViewCellID", for: indexPath) as! BlankViewTableViewCell
            return cell
        }
    }
    
    
}
