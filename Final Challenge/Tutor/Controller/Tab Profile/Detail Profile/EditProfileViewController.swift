//
//  EditProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class EditProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let detailProfile = "DetailHeaderTableViewCellID"
    weak var delegate: LanguageViewControllerDelegate?
    var fullNames:String?
    var arrName:[String]?
    var toolBar = UIToolbar()
    var pickerBirthDate = UIDatePicker()
    var dob:Date?
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Profil")
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
}
extension EditProfileViewController{
    private func getDataCustomCell() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailHeaderTableViewCell
        
        fullNames = cell.nameTF.text ?? ""
        arrName = fullNames?.components(separatedBy: " ")
        
        self.updateUser(name: cell.nameTF.text ?? "", age: cell.ageTF.text ?? "", address: cell.addressTF.text ?? "")
    }
    
    func updateUser(name:String, age:String, address:String){
        if let record = tutors{
            if fullNames?.isEmpty == false{
                let first = arrName?[0] ?? ""
                let second = arrName?[1] ?? ""
                record["tutorFirstName"] = first
                record["tutorLastName"] = second
            }
            record["tutorAddress"] = address
            record["tutorBirthDate"] = dob ?? ""
            
            
            self.database.save(record, completionHandler: {returnRecord, error in
                if error != nil
                {
                    self.showAlert(title: "Error", message: "Update Error")
                } else{
                }
            })
        }
    }
    
}
extension EditProfileViewController:ProfileDetailProtocol,PasswordProtocol,BirthProtocol{
    func dropBirth() {
        createBirthDate()
    }
    
    func applyProfile() {
        getDataCustomCell()
    }
    
    func changePassword() {
        let destVC = EditPasswordViewController()
        destVC.tutors = self.tutors
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension EditProfileViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! DetailHeaderTableViewCell
        let fName = "\(tutors?.value(forKey: "tutorFirstName") as! String) \(tutors?.value(forKey: "tutorLastName") as! String)"
        let tutorAddress = tutors?.value(forKey: "tutorAddress") as! String
        let birth = tutors?.value(forKey: "tutorBirthDate") as! String
        
        cell.nameTF.attributedPlaceholder = NSAttributedString(string: fName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        cell.addressTF.attributedPlaceholder = NSAttributedString(string: tutorAddress, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        cell.ageTF.attributedPlaceholder = NSAttributedString(string: birth, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        cell.setCell(name: fName, age: birth, address: tutorAddress)
        cell.view = self.view
        cell.passwordDelegate = self
        cell.delegate = self
        return cell
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "DetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: detailProfile)
    }
    
}
extension EditProfileViewController{
    private func createBirthDate() {
        pickerBirthDate.tag = 1
        pickerBirthDate.backgroundColor = UIColor.white
        pickerBirthDate.datePickerMode = .date
        pickerBirthDate.autoresizingMask = .flexibleWidth
        pickerBirthDate.contentMode = .center
        pickerBirthDate.setValue(UIColor.black, forKey: "textColor")
        pickerBirthDate.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerBirthDate)
        pickerBirthDate.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        
        createToolbar()
    }
    
    private func createToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerBirthDate.removeFromSuperview()
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
        self.dob = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM yyyy"
        pickerBirthDate.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        pickerBirthDate.minimumDate = Calendar.current.date(byAdding: .year, value: -20, to: Date());
        cell.ageTF.text = dateFormater.string(from: datePicker.date)
    }
}
