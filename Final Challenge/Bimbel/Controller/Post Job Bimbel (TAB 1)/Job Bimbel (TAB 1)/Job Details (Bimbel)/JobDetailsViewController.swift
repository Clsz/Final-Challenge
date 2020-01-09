//
//  JobDetailsViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 05/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class JobDetailsViewController: BaseViewController {
    
    @IBOutlet weak var progressView1: UIView!
    @IBOutlet weak var progressView2: UIView!
    @IBOutlet weak var progressView3: UIView!
    @IBOutlet weak var progressView4: UIView!
    @IBOutlet weak var cvTeachingSubjects: UICollectionView!
    @IBOutlet weak var gradeTV: UITableView!
    @IBOutlet weak var scheduleTV: UITableView!
    @IBOutlet weak var salaryTF: UITextField!
    @IBOutlet weak var qualificationTF: UITextField!
    @IBOutlet weak var postJobButton: UIButton!
    var arraySubject:[String] = []
    var arrayGrade:[String] = []
    var minSalary:String!
    var maxSalary:String!
    var day:[String] = []
    var startHour:[String] = []
    var endHour:[String] = []
    var qualification:String!
    var course:CKRecord!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegateCV()
        cellDelegateTV()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Job Details")
        setMainInterface()
        setData()
        reloadTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func editSubjectTapped(_ sender: Any) {
        let editSubjectVC = TeachingSubjectViewController()
        editSubjectVC.delegate = self
        editSubjectVC.flag = false
        self.navigationController?.pushViewController(editSubjectVC, animated: true)
    }
    
    @IBAction func editGradesTapped(_ sender: Any) {
        let editGrade = TeachingGradeViewController()
        editGrade.delegate = self
        editGrade.flag = false
        self.navigationController?.pushViewController(editGrade, animated: true)
    }
    
    @IBAction func editSalaryTapped(_ sender: Any) {
        editInfo()
    }
    
    @IBAction func editScheduleTapped(_ sender: Any) {
        showAlert(title: "Coming Soon", message: "Under Construction !!")
    }
    
    @IBAction func editQualificationTapped(_ sender: Any) {
        editInfo()
    }
    
    @IBAction func postJobTapped(_ sender: Any) {
        self.showLoading()
        self.queryCourse()
    }
    
}
extension JobDetailsViewController:passDataToDetail{
    func passDataSubject(dataSubject: [String]) {
        self.arraySubject = dataSubject
    }
    
    func passDataGrade(dataGrade: [String]) {
        self.arrayGrade = dataGrade
    }
    
    func passQualification(qualification: String) {
        self.qualification = qualification
    }
    
    func passSalary(minSalary: String, maxSalary: String) {
        self.minSalary = minSalary
        self.maxSalary = maxSalary
    }
    
    func passDataSchedule(day: [String], startHour: [String], endHour: [String]) {
        self.day = day
        self.startHour = startHour
        self.endHour = endHour
    }
    
}
extension JobDetailsViewController{
    private func setMainInterface() {
        self.postJobButton.loginRound()
        self.qualificationTF.setBorderBlue()
        self.qualificationTF.outerRound()
        self.salaryTF.setBorderBlue()
        self.salaryTF.outerRound()
        progressView1.outerRound()
        progressView2.outerRound()
        progressView3.outerRound()
        progressView4.outerRound()
    }
    
    private func registerCell() {
        cvTeachingSubjects.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubjectCollectionViewCellID")
        gradeTV.register(UINib(nibName: "TeachingGradePlainTableViewCell", bundle: nil), forCellReuseIdentifier: "TeachingGradePlainTableViewCellID")
        scheduleTV.register(UINib(nibName: "InterviewBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "InterviewBimbelTableViewCellID")
    }
    
    private func reloadTable() {
        self.cvTeachingSubjects.reloadData()
        self.gradeTV.reloadData()
        self.scheduleTV.reloadData()
    }
    
    private func setData() {
        salaryTF.text = "\(String(describing: minSalary!)) - \(String(describing: maxSalary!))"
        qualificationTF.text = String(qualification!)
    }
    
    private func editInfo() {
        let editInfo = JobInformationViewController()
        editInfo.delegate = self
        editInfo.flag = false
        editInfo.day = self.day
        editInfo.startHour = self.startHour
        editInfo.endHour = self.endHour
        self.navigationController?.pushViewController(editInfo, animated: true)
    }
    
    private func queryCourse() {
        let token = CKUserData.shared.getEmailBimbel()
        let pred = NSPredicate(format: "courseEmail == %@", token)
        let query = CKQuery(recordType: "Course", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            self.course = records[0]
            if error != nil{
                self.hideLoading()
                return self.showAlert(title: "Attention", message: "Error Saving Data !")
            }
            DispatchQueue.main.async {
                self.createJob()
            }
            
        }
    }
    
    private func createJob(){
        let record = CKRecord(recordType: "Job")
        let tokenMin = minSalary.replacingOccurrences(of: ".", with: "").components(separatedBy: " ")
        let tokenMax = maxSalary.replacingOccurrences(of: ".", with: "").components(separatedBy: " ")
        
        record["courseAddress"] = course?.value(forKey: "courseAddress") as? String
        record["courseCity"] = course?.value(forKey: "courseCity") as? String ?? ""
        record["courseID"] = CKRecord.Reference.init(recordID: course.recordID, action: .none)
        record["courseName"] = course?.value(forKey: "courseName") as? String
        record["jobSubject"] = arraySubject
        record["jobGrade"] = arrayGrade
        record["minimumSalary"] = Double(tokenMin[1])
        record["maximumSalary"] = Double(tokenMax[1])
        record["jobQualification"] = qualification
        record["jobScheduleDay"] = day
        record["jobScheduleStart"] = startHour
        record["jobScheduleEnd"] = endHour
        
        database.save(record) { (record, error) in
            //Tanya mentor
            guard record != nil  else { return print("Error") }
            self.updateToCourse(recordApplicant: record!)
        }
    }
    
    private func updateToCourse(recordApplicant:CKRecord) {
        if let record = course{
            var tempJob = course.value(forKey: "jobID") as? [CKRecord.Reference] ?? []
            let jobID = CKRecord.Reference.init(recordID: recordApplicant.recordID, action: .none)
            tempJob.append(jobID)
            record["jobID"] = tempJob
            self.database.save(record, completionHandler: {returnedRecord, error in
                if error != nil {
                    self.showAlert(title: "Error", message: "Cannot update :(")
                }
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }
        
    }
    
}
extension JobDetailsViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func cellDelegateCV() {
        self.cvTeachingSubjects.dataSource = self
        self.cvTeachingSubjects.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arraySubject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvTeachingSubjects.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCellID", for: indexPath) as! SubjectCollectionViewCell
        cell.setView(subject: arraySubject[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
}
extension JobDetailsViewController:UITableViewDataSource, UITableViewDelegate{
    private func cellDelegateTV() {
        self.gradeTV.dataSource = self
        self.gradeTV.delegate = self
        self.scheduleTV.dataSource = self
        self.scheduleTV.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == gradeTV{
            return arrayGrade.count
        }else{
            return day.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == gradeTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeachingGradePlainTableViewCellID", for: indexPath) as! TeachingGradePlainTableViewCell
            cell.setCell(text: arrayGrade[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InterviewBimbelTableViewCellID", for: indexPath) as! InterviewBimbelTableViewCell
            let timeSchedule = "\(startHour[indexPath.row]) - \(endHour[indexPath.row]) WIB"
            cell.setCell(day: day[indexPath.row], time: timeSchedule)
            return cell
        }
    }
    
}
