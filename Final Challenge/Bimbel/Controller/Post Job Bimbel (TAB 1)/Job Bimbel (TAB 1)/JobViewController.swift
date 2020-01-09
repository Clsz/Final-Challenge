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
    
    @IBOutlet weak var titleTableView: UILabel!
    @IBOutlet weak var buttonPostJob: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postNoData: UIButton!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var imageNoData: UIImageView!
    @IBOutlet weak var postJobImage: UIImageView!
    
    var listJobs = [CKRecord]()
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    let cellJob = "postedJobCell"
    var course:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupInterface()
        queryCourse()
        setupView(text: "Post a Job")
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func postJobTapped(_ sender: Any) {
        let destVC = TeachingSubjectViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension JobViewController{
    private func setupInterface() {
        buttonPostJob.loginRound()
        postNoData.loginRound()
        if listJobs.count != 0{
            postNoData.isHidden = true
            caption.isHidden = true
            imageNoData.isHidden = true
            
            postJobImage.isHidden = false
            buttonPostJob.isHidden = false
            titleTableView.isHidden = false
            tableView.isHidden = false
        }else{
            postNoData.isHidden = false
            caption.isHidden = false
            imageNoData.isHidden = false
            
            postJobImage.isHidden = true
            buttonPostJob.isHidden = true
            titleTableView.isHidden = true
            tableView.isHidden = true
        }
    }
    
    func queryCourse() {
        let token = CKUserData.shared.getEmailBimbel()
        let pred = NSPredicate(format: "courseEmail == %@", token)
        let query = CKQuery(recordType: "Course", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            if records.count > 0{
                self.course = records[0]
                DispatchQueue.main.async {
                    self.queryJob()
                }
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
                self.setupInterface()
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
        let subject = (listJobs[indexPath.row].value(forKey: "jobSubject") as! [String])
        let joined = subject.joined(separator: ", ")
        
        let minFare = (listJobs[indexPath.row].value(forKey: "minimumSalary") as! Double)
        let maxFare = (listJobs[indexPath.row].value(forKey: "maximumSalary") as! Double)
        let gajiBimbel =  "Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))"
        cell.setBorder()
        cell.setCell(number: number, subject: joined, salary: gajiBimbel)
        
        return cell
    }
    
}

