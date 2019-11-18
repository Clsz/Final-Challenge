//
//  DetailBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailBimbelViewController: BaseViewController {
    @IBOutlet weak var detailBimbelTV: UITableView!
    
    var dataArray:[Any?] = []
    var course:Courses!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupData()
        //        getData()
        //        detailBimbelTV.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Detail Pekerjaan")
    }
    
}

extension DetailBimbelViewController{
    func setupData() {
        dataArray.removeAll()
        dataArray.append(course)
        dataArray.append(("Address",course.courseAddress,0))
        dataArray.append(("Subject Category",course.courseCategory))
        dataArray.append(("Grade",course.courseGrade))
        dataArray.append(("Range Salary","Rp \(String(describing: course.courseMinFare!)) - Rp \(String(describing: course.courseMaxFare!))",1))
        dataArray.append(("Schedule",course.courseWorkTime,course.courseWorkSchedule))
        dataArray.append(("Qualification",course.courseWorkQualification,0))
        dataArray.append(true)
    }
    
}
extension DetailBimbelViewController:DetailBimbel{
    func requestTapped() {
        let destVC = DetailTestViewController()
        destVC.course = self.course
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension DetailBimbelViewController: UITableViewDataSource,UITableViewDelegate{
    func cellDelegate(){
        detailBimbelTV.dataSource = self
        detailBimbelTV.delegate = self
    }
    
    func registerCell() {
        detailBimbelTV.register(UINib(nibName: "ProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: "profileBimbelCell")
        detailBimbelTV.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        detailBimbelTV.register(UINib(nibName: "SubjectCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
        detailBimbelTV.register(UINib(nibName: "SalaryTableViewCell", bundle: nil), forCellReuseIdentifier: "salaryCell")
        detailBimbelTV.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        detailBimbelTV.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            if let course = dataArray[indexPath.row] as? Courses {
                print(indexPath.row)
                cell.setView(image: course.courseImage, name: course.courseName, lokasi: course.courseLocation)
            }
            return cell
        }
            
        else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
            cell.contentDelegate = self
            return cell
        }
        return UITableViewCell()
    }
}
