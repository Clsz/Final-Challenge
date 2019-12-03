//
//  DetailBimbelTabFirstViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 18/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailBimbelTabFirstViewController: BaseViewController {
    @IBOutlet weak var detailBimbelFirst: UITableView!
    
    var dataArray:[Any?] = []
    var activity:Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.detailBimbelFirst.contentInsetAdjustmentBehavior = .never
        setupView(text: "Detail Pekerjaan")
    }
}

extension DetailBimbelTabFirstViewController{
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(activity)
        dataArray.append(("Address",activity.courseAddress,0))
        dataArray.append(("Subject Category",activity.courseCategory))
        dataArray.append(("Grade",activity.courseGrade))
        dataArray.append(("Range Salary","Rp \(String(describing: activity.courseMinFare!.formattedWithSeparator)) - Rp \(String(describing: activity.courseMaxFare!.formattedWithSeparator))",1))
        dataArray.append(("Schedule",activity.courseWorkSchedule,activity.courseWorkTime))
        dataArray.append(("Qualification",activity.courseWorkQualification,0))
    }
    
}

extension DetailBimbelTabFirstViewController: UITableViewDataSource,UITableViewDelegate{
    func cellDelegate(){
        detailBimbelFirst.dataSource = self
        detailBimbelFirst.delegate = self
    }
    
    func registerCell() {
        detailBimbelFirst.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        detailBimbelFirst.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        detailBimbelFirst.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        detailBimbelFirst.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        detailBimbelFirst.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        detailBimbelFirst.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            if let activity = dataArray[indexPath.row] as? Activity {
                cell.setView(image: activity.courseImage, name: activity.courseName, lokasi: activity.activityStatus)
            }
            return cell
        }
            
        else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
                cell.setView(title: keyValue.key, description: keyValue.value)
                return cell
            }
            else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "salaryCell", for: indexPath) as! SalaryTableViewCell
                cell.setView(title: keyValue.key, salary: keyValue.value)
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:[String]){
            let cell = tableView.dequeueReusableCell(withIdentifier: "subjekCell", for: indexPath) as! SubjectCategoryTableViewCell
            cell.setView(title: keyValue.key)
            cell.subject = keyValue.value
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:[String], desc:[String]){
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
            cell.setView(title: keyValue.key)
            cell.day = keyValue.value
//            cell.schedule = keyValue.desc
            return cell
        }
        return UITableViewCell()
    }
}

