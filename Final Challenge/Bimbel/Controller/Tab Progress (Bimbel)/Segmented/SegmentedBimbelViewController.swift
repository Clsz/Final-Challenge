//
//  SegmentedBimbelViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SegmentedBimbelViewController: BaseViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var activity:[CKRecord] = []
    var courseModel:CKRecord?
    var activityApplied:[CKRecord] = []
    var activityTest:[CKRecord] = []
    var activityResult:[CKRecord] = []
    var currentTableView:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableView = 0
        registerCell()
        cellDelegate()
        setMainInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryCourse()
        setupView(text: "Activities")
        tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.currentTableView = sender.selectedSegmentIndex
        self.tableView.reloadData()
    }
    
    private func setMainInterface() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        let title = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentView.setTitleTextAttributes(title, for: .normal)
        segmentView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        segmentView.selectedSegmentTintColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
    }
    
}
extension SegmentedBimbelViewController{
    func queryCourse() {
        let token = CKUserData.shared.getToken()
        
        let pred = NSPredicate(format: "courseEmail == %@", token)
        
        let query = CKQuery(recordType: "Course", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            
            self.courseModel = record[0]
            DispatchQueue.main.async {
                self.queryActivity()
            }
        }
    }
    
    private func queryActivity() {
        let arrApplicant = courseModel?.value(forKey: "jobID") as! [CKRecord.Reference]
        let pred = NSPredicate(format: "jobID IN %@", arrApplicant)
        let query = CKQuery(recordType: "Applicant", predicate: pred)
        self.flushArray()
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.activity = sortedRecords
            DispatchQueue.main.async {
                for i in self.activity{
                    if (i.value(forKey: "status") as! String) == "Job Requested"{
                        self.activityApplied.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for Your Test Schedule"{
                        self.activityTest.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for Test"{
                        self.activityTest.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for New Test Schedule"{
                        self.activityTest.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for Your Approval"{
                        self.activityResult.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for Applicant Approval"{
                        self.activityResult.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Accepted"{
                        self.activityResult.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Declined"{
                        self.activityResult.append(i)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func flushArray() {
        self.activity.removeAll()
        self.activityApplied.removeAll()
        self.activityTest.removeAll()
        self.activityResult.removeAll()
    }
    
}
extension SegmentedBimbelViewController:UITableViewDataSource, UITableViewDelegate{
    
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "progressCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentTableView == 0{
            return activityApplied.count
        }else if currentTableView == 1{
            return activityTest.count
        }else{
            return activityResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressTableViewCell
        
        if currentTableView == 0{
            let name = (activityApplied[indexPath.row].value(forKey: "tutorName") as? String) ?? ""
            let status = "Waiting for Your Response"
            cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            cell.setCell(nama: name, status: status)
        }else if currentTableView == 1{
            let name = (activityTest[indexPath.row].value(forKey: "tutorName") as? String) ?? ""
            let status = (activityTest[indexPath.row].value(forKey: "status") as? String) ?? ""
            cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            cell.setCell(nama: name, status: status)
        }else{
            let name = (activityResult[indexPath.row].value(forKey: "tutorName") as? String) ?? ""
            let status = (activityResult[indexPath.row].value(forKey: "status") as? String) ?? ""
            if status == "Accepted"{
                cell.statusBimbel.textColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
            }else if status == "Declined"{
                cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.3333333333, blue: 0.2980392157, alpha: 1)
            }else{
                cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            }
            cell.setCell(nama: name , status: status)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentTableView == 0{
            let destVC = ApplicantProfileViewController()
            destVC.tutorReference = (activityApplied[indexPath.row].value(forKey: "tutorID") as! CKRecord.Reference)
            destVC.jobStatus = "Waiting for Your Response"
            destVC.applicant = activityApplied[indexPath.row]
            self.navigationController?.pushViewController(destVC, animated: true)
        }else if currentTableView == 1{
            let destVC = TestScheduleViewController()
            destVC.tutorReference = (activityTest[indexPath.row].value(forKey: "tutorID") as! CKRecord.Reference)
            destVC.jobStatus = activityTest[indexPath.row].value(forKey: "status") as? String
            destVC.applicant = activityTest[indexPath.row]
            self.navigationController?.pushViewController(destVC, animated: true)
        }else{
            let data = (activityResult[indexPath.row].value(forKey: "status") as? String) ?? ""
            if data == "Waiting for Your Approval"{
                let destVC = WaitingForApprovalViewController()
                destVC.tutorReference = (activityResult[indexPath.row].value(forKey: "tutorID") as! CKRecord.Reference)
                destVC.jobStatus = data
                destVC.applicant = activityResult[indexPath.row];
                self.navigationController?.pushViewController(destVC, animated: true)
            }else{
                let destVC = ResultBimbelViewController()
                destVC.tutorReference = (activityResult[indexPath.row].value(forKey: "tutorID") as! CKRecord.Reference)
                destVC.jobStatus = (activityResult[indexPath.row].value(forKey: "status") as! String)
                self.navigationController?.pushViewController(destVC, animated: true)
            }
        }
    }
    
}
