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
    var course:Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupData()
        getData()
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
        dataArray.append(("Address","Aa",0))
        dataArray.append(("Qualification","Aa",0))
        dataArray.append(("Subject Category","",1))
        dataArray.append(("Grade","",1))
        dataArray.append(("Range Salary","Aa",2))
        dataArray.append(("Schedule","",3))
    }
    
    func getData() {
        self.course  = Course("01", "Next Level Bimbel", "BSD Anggrek Loka Jalan Anggrek Ungu Blok A No 1A Sektor 2-1 Serpong, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15310", "12345", ["2000000"], ["3000000"], ["09.00 A.M - 08.00 PM", "01.00 PM - 04.00 PM"], ["Pendidikan minimal SMA/sederajat", "Lebih disukai yang memiliki pengalaman mengajar sebelumnya", "Jujur, pekerja keras, rajin dan tanggung jawab", "Komitmen mengajar selama minimal 6 bulan", "Memiliki kesabaran terhadap anak-anak"], ["Matematika", "IPA", "IPS"], ["SD","SMP"] )
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
//        detailBimbelTV.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "submitCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(dataArray)
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBimbelCell", for: indexPath) as! ProfileBimbelTableViewCell
            if let course = dataArray[indexPath.row] as? Course {
                cell.setView(image: course.courseImage, name: course.courseName, lokasi: "BSD")
            }
            return cell
        }
            
        else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
                cell.setView(title: keyValue.key, description: keyValue.key)
                return cell
            }
            else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "subjekCell", for: indexPath) as! SubjectCategoryTableViewCell
                cell.setView(title: keyValue.key)
                return cell
            }
            else if keyValue.code == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "salaryCell", for: indexPath) as! SalaryTableViewCell
                cell.setView(title: keyValue.key, salary: keyValue.key)
                return cell
            }
            else if keyValue.code == 3{
                let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
                cell.setView(title: keyValue.key)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}


