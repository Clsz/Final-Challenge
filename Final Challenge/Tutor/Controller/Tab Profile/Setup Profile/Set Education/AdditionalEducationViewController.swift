//
//  AdditionalEducationViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class AdditionalEducationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAdditional: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    let hint = "HintTableViewCellID"
    let CustomExperienceTableViewCell = "CustomExperienceTableViewCellID"
    var dataSchoolName:[String] = []
    var dataGrade:[String] = []
    var dataFieldStudy:[String] = []
    var dataStart:[Int] = []
    var dataEnd:[Int] = []
    var dataGpa:[Double] = []
    var listEducation = [CKRecord]()
    var tutors:CKRecord?
    var education:Education?
    var dataArray:[Education] = []
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        queryEducation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Education")
        queryEducation()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    @IBAction func addAddtionalTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
}
extension AdditionalEducationViewController{
    private func setMainInterface() {
        self.addAdditional.loginRound()
        self.applyButton.loginRound()
    }
    
    private func queryEducation() {
        let educationID = tutors?.value(forKey: "educationID") as! CKRecord.Reference
        let pred = NSPredicate(format: "recordID == %@", educationID)
        let query = CKQuery(recordType: "Education", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.listEducation = sortedRecords
            DispatchQueue.main.async {
                self.setData()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setData() {
        for i in listEducation{
            self.dataSchoolName = i.value(forKey: "schoolName") as! [String]
            self.dataGrade = i.value(forKey: "grade") as! [String]
            self.dataFieldStudy = i.value(forKey: "fieldOfStudy") as! [String]
        }
    }
}
extension AdditionalEducationViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: CustomExperienceTableViewCell)
    }
    
    func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSchoolName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
        
//        let fos = "Field of Study: \(dataFieldStudy[indexPath.row])"
        
        
        cell.setCell(name: dataSchoolName[indexPath.row] , place: dataGrade[indexPath.row], date: "Field of Study: \(dataFieldStudy[indexPath.row])")
        
        
        return cell}
}

