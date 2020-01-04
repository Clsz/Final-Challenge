//
//  JobViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 03/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class JobViewController: BaseViewController {
    
    @IBOutlet weak var buttonPostJob: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var listJobs = [CKRecord]()
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    let cellJob = "postedJobCell"
    var course:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        registerCell()
        cellDelegate()
        queryCourse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Post a Job")
    }
    
}


extension JobViewController{
    func setButton(){
        buttonPostJob.outerRound3()
    }
    
    func queryCourse() {
        let token = CKUserData.shared.getTokenBimbel()
        let pred = NSPredicate(format: "courseEmail == %@", token)
        let query = CKQuery(recordType: "Course", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            self.course = records[0]
            DispatchQueue.main.async {
                self.queryJob()
            }
        }
    }
    
    private func queryJob() {
        let pred = NSPredicate(format: "courseID = %@", CKRecord.ID(recordName: (course?.recordID.recordName)!))
        let query = CKQuery(recordType: "Job", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.listJobs = record
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension JobViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func registerCell() {
        self.tableView.register(UINib(nibName: "JobBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: cellJob)
    }
    
    private func cellDelegate() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellJob, for: indexPath) as! JobBimbelTableViewCell
        
        let number = (listJobs[indexPath.row].value(forKey: "courseName") as! String)
        let subject = (listJobs[indexPath.row].value(forKey: "courseSubject") as! [String])
        let joined = subject.joined(separator: ", ")
        
        let minFare = (listJobs[indexPath.row].value(forKey: "courseFareMinimum") as! Int)
        let maxFare = (listJobs[indexPath.row].value(forKey: "courseFareMaximum") as! Int)
        let gajiBimbel =  "Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))"
        
        cell.setCell(number: number, subject: joined, salary: gajiBimbel)
        
        return cell
    }
    
}

