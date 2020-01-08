//
//  SetupPersonalBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 16/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SetupPersonalBimbelViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let hint = "HintTableViewCellID"
    let detailProfile = "SetupPersonalBimbelTableViewCellID"
    var toolBar = UIToolbar()
    var pickerStartHour = UIDatePicker()
    var pickerEndHour = UIDatePicker()
    var photoPicker = UIImagePickerController()
    var course:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        queryCourse()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        self.tableView.reloadData()
        self.tableView.contentInsetAdjustmentBehavior = .never
        setupView(text: "Bimbel Personal")
    }
    
    
}
extension SetupPersonalBimbelViewController{
    
    private func getDataCustomCell() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
        
        
        self.updateUser(name: cell.nameTF.text ?? "", address: cell.addressTF.text ?? "", startHour: cell.startTF.text ?? "", endHour: cell.endTF.text ?? "") { (res) in
            if res == true{
                
            }
        }
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
    
    func queryCourse() {
        let token = CKUserData.shared.getEmailBimbel()
        let pred = NSPredicate(format: "courseEmail == %@", token)
        let query = CKQuery(recordType: "Course", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            if record.count > 0 {
                self.course = record[0]
                DispatchQueue.main.async {
                    self.cellDelegate()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func updateUser(name:String, address:String, startHour:String, endHour:String, completion: @escaping (Bool) -> Void){
        
        if let record = course{
            let index = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
            
            let tempImg = course?["courseImage"]  as?  CKAsset
            cell.imageProfilBimbel.image =  tempImg?.toUIImage()
            
            let newImageData = cell.imageProfilBimbel.image?.jpegData(compressionQuality: 0.00000000000000001)
            if let newImage = newImageData{
                let imageData = createAsset(data: newImage)
                record["courseImage"] = imageData
            }
            
            record["courseName"] = name
            record["courseAddress"] = address
            record["courseStartHour"] = startHour
            record["courseEndHour"] = endHour
            
            
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
        let vc = SetupSubjectBimbelViewController()
        vc.course = self.course
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SetupPersonalBimbelViewController:ProfileDetailProtocol,PhotoProtocol,BimbelPersonalProtocol{
    func startTapped() {
        createStartHour()
    }
    
    func closeTapped() {
        createEndHour()
    }
    
    func applyProfile() {
        self.showLoading()
        getDataCustomCell()
    }
    
    func photoTapped() {
        createImagePicker()
    }
    
}

extension SetupPersonalBimbelViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: hint, for: indexPath) as! HintTableViewCell
            
            cell.setCell(text: "PLEASE SET YOUR BIMBEL PROFILE")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! SetupPersonalBimbelTableViewCell
            
            cell.setCell(name: "", address: "")
            cell.selectionStyle = .none
            
            cell.contentDelegate = self
            cell.photoDelegate = self
            cell.timeDelegate = self
            
            
            cell.view = self.view
            return cell
        }
        
    }
    
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "SetupPersonalBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: detailProfile)
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
    }
    
}
extension SetupPersonalBimbelViewController{
    private func createStartHour() {
        pickerStartHour.tag = 0
        pickerStartHour.backgroundColor = UIColor.white
        pickerStartHour.datePickerMode = .time
        pickerStartHour.autoresizingMask = .flexibleWidth
        pickerStartHour.contentMode = .center
        pickerStartHour.setValue(UIColor.black, forKey: "textColor")
        pickerStartHour.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerStartHour)
        pickerStartHour.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        
        createToolbar()
    }
    
    private func createEndHour() {
        pickerEndHour.tag = 1
        pickerEndHour.backgroundColor = UIColor.white
        pickerEndHour.datePickerMode = .time
        pickerEndHour.autoresizingMask = .flexibleWidth
        pickerEndHour.contentMode = .center
        pickerEndHour.setValue(UIColor.black, forKey: "textColor")
        pickerEndHour.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerEndHour)
        pickerEndHour.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        
        createToolbar()
    }
    
    private func createToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerStartHour.removeFromSuperview()
        pickerEndHour.removeFromSuperview()
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
        if datePicker.tag == 0 {
            //            self.start = datePicker.date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            cell.startTF.text = timeFormatter.string(from: datePicker.date)
        } else {
            //            self.end = datePicker.date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            cell.endTF.text = timeFormatter.string(from: datePicker.date)
        }
    }
    
}

extension SetupPersonalBimbelViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            cell.imageProfilBimbel.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

