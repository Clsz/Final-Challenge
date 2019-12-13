//
//  AdditionalLanguageViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class AdditionalLanguageViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAdditional: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    let hint = "HintWithTableTableViewCellID"
    let CustomExperienceTableViewCell = "CustomExperienceTableViewCellID"
    var dataLanguage:[String] = []
     var dataProfiency:[String] = []
    var listLanguage = [CKRecord]()
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        queryLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Language Setup")
        queryLanguage()
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    @IBAction func addAdditionalTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyTapped(_ sender: Any) {
       let destVC = SetupExperienceViewController()
        destVC.tutors = tutors
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension AdditionalLanguageViewController{
    private func setMainInterface() {
        self.addAdditional.loginRound()
        self.applyButton.loginRound()
    }
    
    private func queryLanguage() {
        let languageID = tutors?.value(forKey: "languageID") as! CKRecord.Reference
        let pred = NSPredicate(format: "recordID == %@", languageID)
        let query = CKQuery(recordType: "Language", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.listLanguage = sortedRecords
            DispatchQueue.main.async {
                self.setData()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setData() {
        for i in listLanguage{
            self.dataLanguage = i.value(forKey: "languageName") as! [String]
            self.dataProfiency = i.value(forKey: "languageLevel") as! [String]
        }
    }
}
extension AdditionalLanguageViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "HintWithTableTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: CustomExperienceTableViewCell)
    }
    
    func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
                
        cell.setCell(name: dataLanguage[indexPath.row], place: dataProfiency[indexPath.row], date: "")
                
                
                return cell
    }
    
    
}
