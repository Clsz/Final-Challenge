////
////  DetailMahasiswaViewController.swift
////  Final Challenge
////
////  Created by Steven Gunawan on 03/12/19.
////  Copyright © 2019 12. All rights reserved.
////
//
//import UIKit
//import CloudKit
//
//class DetailMahasiswaViewController: BaseViewController {
//    var dataArray:[Any?] = []
//    var tutor:CKRecord!
//    var education:CKRecord?
//    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
//    
//    @IBOutlet weak var detailMahasiswaTV: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        cellDelegate()
//        register()
//        requestEducation()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        setupView(text: "Profile")
//        setupData()
//    }
//    
//    
//    
//    
//}
//
//extension DetailMahasiswaViewController{
//    private func setupData() {
//        dataArray.removeAll()
//        dataArray.append(tutor)
//        let address = (tutor?.value(forKey: "tutorAddress") as! String)
//        dataArray.append(("Address",address,0))
//        
//        let subject = (tutor?.value(forKey: "courseSubject") as! [String])
//        dataArray.append(("Subject Category", subject))
//        
//        let grade = (course?.value(forKey: "courseGrade") as! [String])
//        dataArray.append(("Grade", grade))
//        let minFare = (course?.value(forKey: "courseFareMinimum") as! Double)
//        let maxFare = (course?.value(forKey: "courseFareMaximum") as! Double)
//        dataArray.append(("Range Salary","Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))",1))
//        dataArray.append("Schedule")
//        
//        dataArray.append(true)
//    }
//    
//    private func requestEducation() {
//        let listEducationID = (tutor?.value(forKey: "educationID") as! CKRecord.Reference)
//        let pred = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: listEducationID.recordID.recordName))
//        let query = CKQuery(recordType: "Education", predicate: pred)
//        
//        database.perform(query, inZoneWith: nil) { (records, error) in
//            guard let record = records else {return}
//            let sortedRecords = record.sorted(by: { $0.creationDate! > $1.creationDate! })
//            self.education = sortedRecords.first
//            DispatchQueue.main.async {
//                self.cellDelegate()
//                self.detailMahasiswaTV.reloadData()
//            }
//        }
//    }
//    
//}
//
//extension DetailMahasiswaViewController: UITableViewDelegate, UITableViewDataSource {
//    func cellDelegate() {
//        detailMahasiswaTV.delegate = self
//        detailMahasiswaTV.dataSource = self
//    }
//    
//    func register() {
//        detailMahasiswaTV.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCellID")
//        detailMahasiswaTV.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCellID", for: indexPath) as! TitleTableViewCell
//            let fName = (tutor.value(forKey: "tutorFirstName") as! String) + (tutor.value(forKey: "tutorLastName") as! String)
//            let birthDate = (tutor.value(forKey: "tutorBirthDate") as! String)
//            let status = (tutor.value(forKey: "tutorStatus") as! String)
//            cell.setCellBimbel(image: "user-5", name: fName, umur: birthDate, status: status)
//            return cell
//        }
//        else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, third:String, code:Int){
//            if keyValue.code == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentViewTableViewCellID", for: indexPath) as! ContentViewTableViewCell
//                cell.setView(title: keyValue.key, description: keyValue.value)
//                return cell
//            }
//        }
//        else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
//            if keyValue.code == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
//                cell.setView(title: keyValue.key, description: keyValue.value)
//                return cell
//            }
//        }
//        return UITableViewCell()
//    }
//}
//
//
//
//}
