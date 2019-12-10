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
    var selectedBirthDate: String?
    var toolBar = UIToolbar()
    var pickerBirthDate = UIDatePicker()
    var dob:Date?
    var firstName:String?
    var lastName:String?
    var fullNames:String?
    var arrName:[String]?
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryUser()
        registerCell()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Personal")
    }
}
extension SetupPersonalViewController{
    private func getDataCustomCell() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
        fullNames = cell.nameTF.text ?? ""
        arrName = fullNames?.components(separatedBy: " ")
        
        self.updateUser(name: cell.nameTF.text ?? "", age: cell.ageTF.text ?? "", address: cell.addressTF.text ?? "")
    }
    
    func queryUser() {
        let token = CKUserData.shared.getToken()
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            if record.count > 0 {
                self.tutors = record[0]
                DispatchQueue.main.async {
                    self.cellDelegate()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func updateUser(name:String, age:String, address:String){
        if let record = tutors{
            let first = arrName?[0] ?? ""
            let second = arrName?[1] ?? ""
            record["tutorFirstName"] = first
            record["tutorLastName"] = second
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

extension SetupPersonalViewController:ProfileDetailProtocol{
    func applyProfile() {
        getDataCustomCell()
    }
    
}

extension SetupPersonalViewController:BirthProtocol{
    func dropBirth() {
        createBirthDate()
    }
}

extension SetupPersonalViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! SetupPersonalTableViewCell
        let fName = "\(tutors?.value(forKey: "tutorFirstName") as! String) \(tutors?.value(forKey: "tutorLastName") as! String)"
        
        cell.nameTF.attributedPlaceholder = NSAttributedString(string: fName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        cell.setCell(name: fName, age: "Choose your DOB", address: "Enter your address")
        cell.contentDelegate = self
        cell.birthDelegate = self
        cell.view = self.view
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

extension SetupPersonalViewController{
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

extension SetupPersonalViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func imageTapped(tapGesture: UITapGestureRecognizer){
        let tappedImage = tapGesture.view as! UIImageView
        
        //Codingan untuk Image Picker Controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
                let actionSheet = UIAlertController(title: "Photo Source", message: "Choose your photo evidence ", preferredStyle: .actionSheet)
        
                actionSheet.addAction(.init(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                actionSheet.addAction(.init(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .photoLibrary
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
                self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        cell.imageProfile.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createAsset(data: Data) -> CKAsset? {
        
        var returnAsset: CKAsset? = nil
        
        let tempStr = ProcessInfo.processInfo.globallyUniqueString
        let filename = "\(tempStr)_file.dat"
        let baseURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = baseURL.appendingPathComponent(filename, isDirectory: false)
        
        do {
            try data.write(to: fileURL, options: [.atomicWrite])
            returnAsset = CKAsset(fileURL: fileURL)
        } catch {
            print("Error creating asset: \(error)")
        }
        
        return returnAsset
    }
}
