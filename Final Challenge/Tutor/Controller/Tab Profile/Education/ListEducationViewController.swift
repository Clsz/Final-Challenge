//
//  ListEducationViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ListEducationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    let hint = "HintTableViewCellID"
    let CustomExperienceTableViewCell = "CustomExperienceTableViewCellID"
    var dataSchoolName:[String] = []
    var dataGrade:[String] = []
    var dataFieldStudy:[String] = []
    var dataStart:[String] = []
    var dataEnd:[String] = []
    var dataGpa:[String] = []
    weak var delegate: LanguageViewControllerDelegate?
    var listEducation = [CKRecord]()
    var tutors:CKRecord?
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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func applyTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ListEducationViewController{
    private func setMainInterface() {
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
            self.dataEnd = i.value(forKey: "endYear") as! [String]
            self.dataGpa = i.value(forKey: "gpa") as! [String]
            self.dataStart = i.value(forKey: "startYear") as! [String]
        }
    }
}
extension ListEducationViewController:UITableViewDataSource,UITableViewDelegate{
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
        
        cell.setCell(name: dataSchoolName[indexPath.row] , place: dataGrade[indexPath.row], date: "Field of Study: \(dataFieldStudy[indexPath.row])")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = EducationViewController()
        destVC.tutors = self.tutors
        destVC.arrSchoolName = self.dataSchoolName
        destVC.arrEnd = self.dataEnd
        destVC.arrFOS = self.dataFieldStudy
        destVC.arrGPA = self.dataGpa
        destVC.arrStart = self.dataStart
        destVC.arrGrade = self.dataGrade
        destVC.schoolName = self.dataSchoolName[indexPath.row]
        destVC.endYear = self.dataEnd[indexPath.row]
        destVC.fos = self.dataFieldStudy[indexPath.row]
        destVC.gpa = self.dataGpa[indexPath.row]
        destVC.startYear = self.dataStart[indexPath.row]
        destVC.grade = self.dataGrade[indexPath.row]
        destVC.listEducation = self.listEducation
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}

