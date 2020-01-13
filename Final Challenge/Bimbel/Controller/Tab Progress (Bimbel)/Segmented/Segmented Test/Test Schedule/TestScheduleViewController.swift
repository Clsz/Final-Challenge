//
//  TestScheduleViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class TestScheduleViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var dataArray:[Any?] = []
    var tutorReference:CKRecord.Reference!
    var jobStatus:String?
    var tutor:CKRecord?
    var applicant:CKRecord?
    var day:[String] = []
    var time:[String] = []
    var datePicker:UIDatePicker = UIDatePicker()
    var toolBar = UIToolbar()
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var tokenUser:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTutor()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Applicant Profile")
        setMainInterface()
    }
    
}
extension TestScheduleViewController{
    private func setupWithoutSchedule() {
        dataArray.removeAll()
        dataArray.append("ALL INFORMATION ABOUT YOUR APPLICANT")
        dataArray.append(tutor)
        dataArray.append(true)
        dataArray.append(("Interview Schedule",0))
        dataArray.append(("AddButton",1))
        dataArray.append(false)
    }
    
    private func setupDataWithSchedule() {
        dataArray.removeAll()
        dataArray.append("ALL INFORMATION ABOUT YOUR APPLICANT")
        dataArray.append(tutor)
        dataArray.append(true)
        dataArray.append(("Interview Schedule",0))
        dataArray.append(("List Schedule",-1))
        dataArray.append(("AddButton",1))
        dataArray.append(false)
    }
    
    private func setMainInterface() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        self.day = applicant?.value(forKey: "testDay") as? [String] ?? []
        self.time = applicant?.value(forKey: "testTime") as? [String] ?? []
    }
    
    @objc private func viewTapped(gestureRecognizer:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func queryTutor() {
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: tutorReference.recordID.recordName))
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tutor = record[0]
            DispatchQueue.main.async {
                self.fetchToken()
            }
        }
    }
    
    private func fetchToken() {
        let email = (tutor?.value(forKey: "tutorEmail") as! String)
        let pred = NSPredicate(format: "email == %@", email)
        let query = CKQuery(recordType: "Token", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.tokenUser = record[0]
            DispatchQueue.main.async {
                if self.day.count != 0{
                    self.setupDataWithSchedule()
                    if self.day.count == 3{
                        self.dataArray.remove(at: 5)
                    }
                }
                self.setupWithoutSchedule()
                self.cellDelegate()
                self.tableView.reloadData()
            }
        }
    }
    
    private func updateToDatabase(status:String, completion : @escaping (Bool) -> Void) {
        if let record = applicant{
            record["status"] = status
            record["testDay"] = self.day
            record["testTime"] = self.time
            self.database.save(record, completionHandler: {returnedRecord, error in
                DispatchQueue.main.async {
                    if error != nil {
                        self.showAlert(title: "Error", message: "Cannot update :(")
                    } else {
                        completion(true)
                    }
                }
            })
        }
    }
    
    private func submitTest() {
        let confirmAlert = UIAlertController(title: "Submit the Test Schedule?", message: "Are you sure you want to submit?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.updateToDatabase(status: "Waiting for Your Approval") { (res) in
                self.setMainInterface()
                if res == true{
                    self.sendNotif(message: "Waiting for Your Approval Schedule", destID: 7)
                }
            }
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    private func sendNotif(message:String,destID:Int) {
        let token = self.tokenUser?.value(forKey: "token") as! String
        let sender = self.applicant?.value(forKey: "courseName") as! String
        let request = self.applicant?.value(forKey: "tutorID") as! CKRecord.Reference
        let destVC = ResultViewController()
        destVC.fromID = destID
        
        Service.sendNotification(message: "\(message) \(sender))", token: [token], idSender: sender, idRequest: request.recordID.recordName, tabBar: 1) { (error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(destVC, animated: true)
                    
                }
            }
        }
    }
    
    private func setSchedule() {
        self.setupDataWithSchedule()
        if day.count == 3{
            dataArray.remove(at: 5)
        }
        self.tableView.reloadData()
    }
    
    private func createPickerSchedule() {
        datePicker.tag = 0
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = UIColor.white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.contentMode = .center
        datePicker.setValue(UIColor.black, forKey: "textColor")
        datePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        self.createToolbar()
    }
    
    private func createToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [flexibleSpace, (UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped)))]
        
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM, yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        self.day.append(dateFormatter.string(from: datePicker.date))
        self.time.append(timeFormatter.string(from: datePicker.date))
        self.setSchedule()
    }
    
    @objc func dateChanged(datePicker:UIDatePicker) {
        view.endEditing(true)
    }
    
}
extension TestScheduleViewController:AddInterviewSchedule{
    func addScheduleTapped() {
        self.createPickerSchedule()
    }
    
}
extension TestScheduleViewController:DetailBimbel{
    func requestTapped() {
        if self.day.count != 0 && self.time.count != 0{
            self.submitTest()
        }else{
            self.showAlert(title: "Attention", message: "Please Fill The Schedule")
        }
    }
    
}
extension TestScheduleViewController:JobDetail{
    func seeDetailTapped() {
        let destVC = SeeDetailApplicantViewController()
        destVC.tutor = self.tutor
        destVC.jobStatus = self.jobStatus
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension TestScheduleViewController:UITableViewDataSource, UITableViewDelegate{
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: "HintTableViewCellID")
        tableView.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        tableView.register(UINib(nibName: "SeeDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SeeDetailTableViewCellID")
        tableView.register(UINib(nibName: "HeaderTestTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTestTableViewCellID")
        tableView.register(UINib(nibName: "ContentTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTestTableViewCellID")
        tableView.register(UINib(nibName: "AddTestButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTestButtonTableViewCellID")
        tableView.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HintTableViewCellID", for: indexPath) as! HintTableViewCell
            cell.setCell(text: "ALL INFORMATION ABOUT TEACHER CANDIDATE")
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            cell.statusBimbel.textColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            let name = (tutor?.value(forKey: "tutorFirstName") as! String) + " " + (tutor?.value(forKey: "tutorLastName") as! String)
            let age = tutor?.value(forKey: "tutorBirthDate") as! Date
            let status = ("Status: " + (jobStatus ?? ""))
            cell.setView(image: "school", name: name, jam: age.toYear(), status: status)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:Int){
            if keyValue.value == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTestTableViewCellID", for: indexPath) as! HeaderTestTableViewCell
                cell.setCell(text: "Interview Schedule")
                return cell
            }else if keyValue.value == 1{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddTestButtonTableViewCellID", for: indexPath) as! AddTestButtonTableViewCell
                cell.setInterface()
                cell.delegate = self
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTestTableViewCellID", for: indexPath) as! ContentTestTableViewCell
                cell.date = self.day
                cell.time = self.time
                cell.tableView.reloadData()
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? Bool{
            if keyValue == true{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeeDetailTableViewCellID", for: indexPath) as! SeeDetailTableViewCell
                cell.jobDetailDelegate = self
                cell.setCell(titleButton: "See Teacher Profile")
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
                if self.day.count > 2 && self.time.count > 0{
                    cell.requestButton.backgroundColor = #colorLiteral(red: 0, green: 0.399238348, blue: 0.6880209446, alpha: 1)
                    cell.requestButton.isEnabled = true
                }else{
                    cell.requestButton.backgroundColor = #colorLiteral(red: 0.6070619822, green: 0.6075353622, blue: 0.6215403676, alpha: 0.8470588235)
                    cell.requestButton.isEnabled = false
                }
                cell.contentDelegate = self
                cell.setCell(button: "Submit")
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
