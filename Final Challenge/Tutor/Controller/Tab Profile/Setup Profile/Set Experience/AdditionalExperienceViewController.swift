//
//  AdditionalExperienceViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class AdditionalExperienceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAdditional: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    let hint = "HintWithTableTableViewCellID"
    let CustomExperienceTableViewCell = "CustomExperienceTableViewCellID"
    var dataTitle:[String] = []
    var dataCompanyName:[String] = []
    var dataStartYear:[String] = []
    var dataEndYear:[String] = []
    var listExperience = [CKRecord]()
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        queryExperience()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Experience Setup")
        queryExperience()
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    @IBAction func addAddtionalTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyTapped(_ sender: Any) {
    }
    
}
extension AdditionalExperienceViewController{
    private func setMainInterface() {
        self.addAdditional.loginRound()
        self.applyButton.loginRound()
    }
    
    private func queryExperience() {
        let experienceID = tutors?.value(forKey: "experienceID") as! CKRecord.Reference
        let pred = NSPredicate(format: "recordID == %@", experienceID)
        let query = CKQuery(recordType: "Experience", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.listExperience = sortedRecords
            DispatchQueue.main.async {
                self.setData()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setData() {
        for i in listExperience{
            self.dataTitle = i.value(forKey: "jobTitle") as! [String]
            self.dataCompanyName = i.value(forKey: "jobCompanyName") as! [String]
            self.dataStartYear = i.value(forKey: "jobStartYear") as! [String]
            self.dataEndYear = i.value(forKey: "jobEndYear") as! [String]
        }
    }
    
}
extension AdditionalExperienceViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "HintWithTableTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: CustomExperienceTableViewCell)
    }
    
    func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: hint, for: indexPath) as! HintWithTableTableViewCell
            
            cell.setCell(text: "PLEASE ADD YOUR EXPERIENCE INFORMATION")
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
            let finalDate = "\(dataStartYear[indexPath.row]) - \(dataEndYear[indexPath.row])"
            
            cell.setCell(name: dataTitle[indexPath.row], place: dataCompanyName[indexPath.row], date: finalDate)
            
            return cell
        }
    }
    
}




