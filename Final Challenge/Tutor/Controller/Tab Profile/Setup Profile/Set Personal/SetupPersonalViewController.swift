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
    var toolBar = UIToolbar()
    var pickerBirthDate = UIDatePicker()
    var photoPicker = UIImagePickerController()
    var dob:Date?
    var fullNames:String?
    var arrName:[String]?
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        self.cellDelegate()
        self.tableView.reloadData()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true);
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
    
    func updateUser(name:String, age:String, address:String){
        if let record = tutors{
            let index = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
            
            
            let newImageData = cell.imageProfile.image?.jpegData(compressionQuality: 0.00000000000000001)
            let imageData = createAsset(data: newImageData!)
            
            
            
            if fullNames?.isEmpty == false{
                let first = arrName?[0] ?? ""
                let second = arrName?[1] ?? ""
                record["tutorFirstName"] = first
                record["tutorLastName"] = second
            }
            record["tutorAddress"] = address
            record["tutorBirthDate"] = dob ?? ""
            record["tutorProfileImage"] = imageData
            
            
            self.database.save(record, completionHandler: {returnRecord, error in
                if error != nil{
                    self.showAlert(title: "Error", message: "Update Error")
                }
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.sendVC()
                }
            })
        }
    }
    
    func sendVC() {
        let vc = SetupEducationViewController()
        vc.tutors = self.tutors
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SetupPersonalViewController:ProfileDetailProtocol{
    func applyProfile() {
        self.showLoading()
        getDataCustomCell()
    }
    
}

extension SetupPersonalViewController:BirthProtocol{
    func dropBirth() {
        createBirthDate()
    }
}

extension SetupPersonalViewController:PhotoProtocol, refreshTableProtocol{
    func refreshTableView() {
        tableView.reloadData()
    }
    
    func photoTapped() {
        createImagePicker()
    }
    
    
}

extension SetupPersonalViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! SetupPersonalTableViewCell
        let fName = "\(tutors?.value(forKey: "tutorFirstName") as! String) \(tutors?.value(forKey: "tutorLastName") as! String)"
        
        cell.ageTF.attributedPlaceholder = NSAttributedString(string: "Choose your DOB", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        cell.setCell(name: fName)
        cell.contentDelegate = self
        cell.birthDelegate = self
        cell.photoDelegate = self
        cell.refreshDelegate = self
        cell.view = self.view
        
        if cell.nameTF.text == "" || cell.addressTF.text == "" || cell.ageTF.text == ""{
            cell.applyButton.isEnabled = false
            cell.applyButton.backgroundColor = #colorLiteral(red: 0.6070619822, green: 0.6075353622, blue: 0.6215403676, alpha: 0.8470588235)
        } else{
            cell.applyButton.isEnabled = true
            cell.applyButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        }
        
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
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [flexibleSpace, (UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped)))]
        
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerBirthDate.removeFromSuperview()
        tableView.reloadData()
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

extension SetupPersonalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private func createImagePicker() {
        photoPicker.delegate = self
        //        photoPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose your photo evidence ", preferredStyle: .actionSheet)
        
        actionSheet.addAction(.init(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            self.photoPicker.sourceType = .camera
            self.present(self.photoPicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(.init(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            self.photoPicker.sourceType = .photoLibrary
            self.present(self.photoPicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        //        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            cell.imageProfile.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
