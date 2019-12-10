//
//  SetupPersonalViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SetupPersonalViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let hint = "HintTableViewCellID"
    let detailProfile = "SetupPersonalTableViewCellID"
    var tutor:Tutor!
    var name:String?
    var age:String?
    var address:String?
     var selectedBirthDate: String?
     var toolBar = UIToolbar()
     var pickerBirthDate = UIPickerView()
    private var datePicker: UIDatePicker?
    
    
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
//        queryUser()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Personal")
    }
}
extension SetupPersonalViewController{
    private func getDataCustomCell() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
        self.name = cell.nameTF.text ?? ""
        self.age = cell.ageTF.text ?? ""
        self.address = cell.addressTF.text ?? ""
    }
    
//    func queryUser() {
//        let token = CKUserData.shared.getToken()
//        let pred = NSPredicate(format: "tutorEmail == %@", token)
//        let query = CKQuery(recordType: "Tutor", predicate: pred)
//
//        database.perform(query, inZoneWith: nil) { (records, error) in
//            guard let record = records else {return}
//
//            self.tutors = record[0]
//            DispatchQueue.main.async {
//                self.cellDelegate()
//            }
//        }
//    }
    
}

extension SetupPersonalViewController:ProfileDetailProtocol{
    func applyProfile() {
        getDataCustomCell()
    }
    
}

extension SetupPersonalViewController:BirthProtocol{
    func dropBirth() {
//        createBirthDate()
    }
}

extension SetupPersonalViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! SetupPersonalTableViewCell
//        let fName = (tutors?.value(forKey: "tutorFirstName") as! String) + (tutors?.value(forKey: "tutorLastName") as! String)
        
        cell.setCell(name: "fName", age: "Choose your DOB", address: "Enter your address")
        cell.contentDelegate = self
        return cell
        
    }
    
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "SetupPersonalTableViewCell", bundle: nil), forCellReuseIdentifier: detailProfile)
    }
    
}

//extension SetupPersonalViewController:UIPickerViewDelegate, UIPickerViewDataSource{
//    private func createBirthDate() {
//        pickerBirthDate = UIPickerView.init()
//        pickerBirthDate.tag = 1
//        pickerBirthDate.delegate = self
//        pickerBirthDate.selectRow(5, inComponent:0, animated:true)
//
//        pickerBirthDate.backgroundColor = UIColor.white
//        pickerBirthDate.autoresizingMask = .flexibleWidth
//        pickerBirthDate.contentMode = .center
//        pickerBirthDate.setValue(UIColor.black, forKey: "textColor")
//        pickerBirthDate.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
//        self.view.addSubview(pickerBirthDate)
//
//        createToolbar()
//    }
//
//    private func createToolbar() {
//        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
//        toolBar.items = [UIBarButtonItem.init(title: "Selesai", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
//        self.view.addSubview(toolBar)
//    }
//
//    @objc func onDoneButtonTapped() {
//        let index = IndexPath(row: 1, section: 0)
//        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
//
//        cell.ageTF.text = selectedBirthDate
//        toolBar.removeFromSuperview()
//        pickerBirthDate.removeFromSuperview()
//    }
//
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            return ConstantManager.year.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return ConstantManager.year[row]
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            selectedBirthDate = ConstantManager.year[row]
//    }
//    
//    
//}
