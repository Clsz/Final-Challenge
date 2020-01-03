//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class HomeViewController: BaseViewController{
    
    @IBOutlet weak var jobTableView: UITableView!
    let images = UIImage(named: "school")
    var listJob = [CKRecord]()
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var filteredminSalary:Double = -1
    var filteredmaxSalary:Double = -1
    var filteredLocation:[String] = []
    var filteredGrade:[String] = []
    var filteredSubject:[String] = []
    var homeDelegate:HomeProtocol?
    var tutorModel:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Jobs")
        queryJob()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func filterTapped(_ sender: UIButton) {
        let filterVC = FilterViewController()
        filterVC.sendFilterDelegate = self
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
}
extension HomeViewController{
    private func queryJob() {
        let query:CKQuery!
        var preds:[NSPredicate] = []
        
        let minSalary = filteredminSalary == -1.0 ? 0.0 : filteredminSalary
        let maxSalary = filteredmaxSalary == -1.0 ? 10000000.0 : filteredmaxSalary
        
        let predMinimumSalary = NSPredicate(format: "minimumSalary >= %f", minSalary)
        let predMaximumSalary = NSPredicate(format: "maximumSalary <= %f", maxSalary)
        let predAddress = NSPredicate(format: "courseCity IN %@", filteredLocation)
        
        let predSubject = filteredSubject.map{NSPredicate(format: "jobSubject CONTAINS %@", $0)}
        let predGrades = filteredGrade.map{NSPredicate(format: "jobGrade CONTAINS %@", $0)}
        preds.append(predMinimumSalary)
        preds.append(predMaximumSalary)
        preds.append(predAddress)
        preds.append(contentsOf: predSubject)
        preds.append(contentsOf: predGrades)
        
        let allPred = NSCompoundPredicate(andPredicateWithSubpredicates: preds)
        query = CKQuery(recordType: "Job", predicate: allPred)
        
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else { print("error",error as Any)
                return }

            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.listJob = sortedRecords
            DispatchQueue.main.async {
                self.jobTableView.reloadData()
            }
        }
        
    }

    private func getUser() {
        let token = CKUserData.shared.getToken()
        
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            
            self.tutorModel = record[0]
            DispatchQueue.main.async {
                self.queryJob()
            }
        }
    }
    
}
extension HomeViewController:SendFilter{
    func sendDataFilter(location: [String], minSalary: Double, maxSalary: Double, grade: [String], subject: [String]) {
        self.filteredLocation = location
        self.filteredminSalary = minSalary
        self.filteredmaxSalary = maxSalary
        self.filteredGrade = grade
        self.filteredSubject = subject
    }
    
}
extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJob.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! ListJobTableViewCell
        
    
        let data = listJob[indexPath.row]
        let name = (data.value(forKey: "courseName") as! String)
        let location = (data.value(forKey: "courseCity") as! String)
        let minFare = (data.value(forKey: "minimumSalary") as! Double)
        let maxFare = (data.value(forKey: "maximumSalary") as! Double)
        let gajiBimbel =  "Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))"
        cell.setView(name: name, location: location, subject: gajiBimbel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailBimbelViewController()
        destVC.job = listJob[indexPath.row]
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func cellDelegate(){
        jobTableView.dataSource = self
        jobTableView.delegate = self
    }
    
    func registerCell() {
        jobTableView.register(UINib(nibName: "ListJobTableViewCell", bundle: nil), forCellReuseIdentifier: "jobCell")
    }
    
}

