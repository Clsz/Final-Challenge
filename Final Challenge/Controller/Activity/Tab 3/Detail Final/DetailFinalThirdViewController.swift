//
//  DetailFinalThirdViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailFinalThirdViewController: BaseViewController {
    @IBOutlet weak var detailFinalTV: UITableView!
    var dataArray:[Any?] = []
    var activity:Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupData()
        setupView(text: "Detail Pekerjaan")
    }

}

extension DetailFinalThirdViewController{
    func setupData() {
        dataArray.removeAll()
        dataArray.append(activity)
        dataArray.append(("Address",activity.courseAddress,0))
        dataArray.append(("Subject Category",activity.courseCategory))
        dataArray.append(("Grade",activity.courseGrade))
        dataArray.append(("Range Salary","Rp \(String(describing: activity.courseMinFare!)) - Rp \(String(describing: activity.courseMaxFare!))",1))
        dataArray.append(("Schedule",activity.courseWorkTime,activity.courseWorkSchedule))
        dataArray.append(("Qualification",activity.courseWorkQualification,0))
    }
    
}

extension DetailFinalThirdViewController: UITableViewDataSource,UITableViewDelegate{
    func cellDelegate(){
        detailFinalTV.dataSource = self
        detailFinalTV.delegate = self
    }
    
    func registerCell() {
        detailFinalTV.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        detailFinalTV.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        detailFinalTV.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        detailFinalTV.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        detailFinalTV.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        detailFinalTV.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
        detailFinalTV.register(UINib(nibName: "FooterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterActivityTableViewCellID")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            if let course = dataArray[indexPath.row] as? Activity {
                print(indexPath.row)
                cell.setView(image: course.courseImage, name: course.courseName, lokasi: course.activityStatus)
                cell.lokasiBimbel.textColor = #colorLiteral(red: 0, green: 0.8650887609, blue: 0.320767343, alpha: 1)
            }
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
                print("keyVAlue\(keyValue.value)")
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
            cell.schedule = keyValue.desc
            return cell
        }
        return UITableViewCell()
    }
}

