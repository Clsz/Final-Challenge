//
//  SegmentedViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit
class SegmentedViewController: BaseViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var activity:[CKRecord] = []
    var tutorModel:CKRecord?
    var activityApplied:[CKRecord] = []
    var activityTest:[CKRecord] = []
    var activityResult:[CKRecord] = []
    var currentTableView:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryActivity()
        currentTableView = 0
        registerCell()
        cellDelegate()
        setMainInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Progress")
        tableView.reloadData()
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
extension SegmentedViewController{
    func queryUser() {
        let token = CKUserData.shared.getToken()
        
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        
        let query = CKQuery(recordType: "Tutor", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            
            self.tutorModel = record[0]
            DispatchQueue.main.async {
                self.cellDelegate()
            }
        }
    }
    
    private func queryActivity() {
        let query = CKQuery(recordType: "Applicant", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.activity.append(sortedRecords[0])
            DispatchQueue.main.async {
                for i in self.activity{
                    if (i.value(forKey: "status") as! String) == "Job Requested"{
                        self.activityApplied.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for Your Response"{
                        self.activityTest.append(i)
                    }else if (i.value(forKey: "status") as! String) == "Waiting for Test"{
                        self.activityTest.append(i)
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
    
}

extension SegmentedViewController:UITableViewDataSource, UITableViewDelegate{
    
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
            let name = (activityApplied[indexPath.row].value(forKey: "courseName") as? String) ?? ""
            let status = (activityTest[indexPath.row].value(forKey: "status") as? String) ?? ""
            cell.setCell(nama: name, status: status)
        }else if currentTableView == 1{
            let name = (activityTest[indexPath.row].value(forKey: "courseName") as? String) ?? ""
            let status = (activityTest[indexPath.row].value(forKey: "status") as? String) ?? ""
            cell.setCell(nama: name, status: status)
        }else{
            let name = (activityResult[indexPath.row].value(forKey: "courseName") as? String) ?? ""
            let status = (activityResult[indexPath.row].value(forKey: "status") as? String) ?? ""
            cell.setCell(nama: name , status: status)
        }
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Send data Course and Job Detail
        if currentTableView == 0{
            let destVC = DetailBimbelTabFirstViewController()
            destVC.jobReference = (activityApplied[indexPath.row].value(forKey: "jobID") as! CKRecord.Reference)
            destVC.jobStatus = (activityApplied[indexPath.row].value(forKey: "status") as! String)
            self.navigationController?.pushViewController(destVC, animated: true)
        }else if currentTableView == 1{
            let destVC = DetailTestViewController()
            destVC.jobReference = (activityTest[indexPath.row].value(forKey: "jobID") as! CKRecord.Reference)
            destVC.applicant = activityTest[indexPath.row];          self.navigationController?.pushViewController(destVC, animated: true)
        }else{
            let data = (activityResult[indexPath.row].value(forKey: "status") as? String) ?? ""
            if data == "Accepted"{
                let destVC = WaitingConformationViewController()
                
                self.navigationController?.pushViewController(destVC, animated: true)
            }else{
                let destVC = DetailFinalThirdViewController()
                
                self.navigationController?.pushViewController(destVC, animated: true)
            }
        }
    }
    
}
