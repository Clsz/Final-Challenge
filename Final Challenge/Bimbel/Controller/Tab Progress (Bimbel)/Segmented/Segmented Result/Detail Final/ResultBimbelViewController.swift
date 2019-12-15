//
//  ResultBimbelViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ResultBimbelViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var tutorReference:CKRecord.Reference!
    var jobStatus:String?
    var tutor:CKRecord?
    var applicant:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTutor()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Applicant Profile")
    }
    
}
extension ResultBimbelViewController{
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
                self.setupData()
                self.cellDelegate()
                self.tableView.reloadData()
            }
        }
    }
    
}
extension ResultBimbelViewController:JobDetail{
    func seeDetailTapped() {
        let destVC = SeeDetailApplicantViewController()
        destVC.tutor = self.tutor
        destVC.jobStatus = self.jobStatus
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension ResultBimbelViewController:UITableViewDataSource, UITableViewDelegate{
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
            let name = (tutor?.value(forKey: "tutorFirstName") as! String) + " " + (tutor?.value(forKey: "tutorLastName") as! String)
            let age = tutor?.value(forKey: "tutorBirthDate") as! Date
            let status = ("Status: " + (jobStatus ?? ""))
            if status == "Status: Accepted"{
                cell.statusBimbel.textColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
            }else{
                cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.3333333333, blue: 0.2980392157, alpha: 1)
            }
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
                cell.resultButtonAppear()
                cell.setCell(accept: "Accept", reject: "Reject")
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankViewTableViewCellID", for: indexPath) as! BlankViewTableViewCell
            return cell
        }
    }
    
    
}
