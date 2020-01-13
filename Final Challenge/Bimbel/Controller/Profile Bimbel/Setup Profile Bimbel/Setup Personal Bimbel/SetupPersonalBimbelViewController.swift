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
    var selectedCity: String?
    var selectedProvince: String?
    var toolBar = UIToolbar()
    var pickerStartHour = UIDatePicker()
    var pickerEndHour = UIDatePicker()
    var pickerCity = UIPickerView()
    var pickerProvince = UIPickerView()
    var photoPicker = UIImagePickerController()
    var course:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Tuition Personal")
        registerCell()
        queryCourse()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    
}
extension SetupPersonalBimbelViewController{
    
    private func getDataCustomCell() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
        
        
        self.updateUser(name: cell.nameTF.text ?? "", address: cell.addressTF.text ?? "", startHour: cell.startTF.text ?? "", endHour: cell.endTF.text ?? "", city: cell.cityTF.text ?? "", province: cell.provinceTF.text ?? "") { (res) in
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
    
    func updateUser(name:String, address:String, startHour:String, endHour:String, city:String, province:String, completion: @escaping (Bool) -> Void){
        
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
            record["courseCity"] = city
            record["courseProvince"] = province
            
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

extension SetupPersonalBimbelViewController:ProfileDetailProtocol,PhotoProtocol,BimbelPersonalProtocol,AddressProtocol{
    func cityTapped() {
        createCityPicker()
    }
    
    func provinceTapped() {
        createProvincePicker()
    }
    
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
            
            cell.setCell(text: "PLEASE SET YOUR TUITION PROFILE")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! SetupPersonalBimbelTableViewCell
            
            //            if cell.nameTF.text?.isEmpty == true || cell.addressTF.text?.isEmpty == true || cell.startTF.text?.isEmpty == true || cell.endTF.text?.isEmpty == true || cell.cityTF.text?.isEmpty == true || cell.provinceTF.text?.isEmpty == true{
            //                cell.buttonApply.isEnabled = false
            //                cell.buttonApply.backgroundColor = #colorLiteral(red: 0.6070619822, green: 0.6075353622, blue: 0.6215403676, alpha: 0.8470588235)
            //            }else{
            //                cell.buttonApply.isEnabled = true
            //                cell.buttonApply.backgroundColor = #colorLiteral(red: 0, green: 0.399238348, blue: 0.6880209446, alpha: 1)
            //            }
            
            cell.selectionStyle = .none
            cell.setCell(name: "", address: "")
            cell.view = self.view
            cell.contentDelegate = self
            cell.photoDelegate = self
            cell.timeDelegate = self
            cell.addressDelegate = self
            
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
extension SetupPersonalBimbelViewController:UIPickerViewDelegate, UIPickerViewDataSource{
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
    
    func createCityPicker() {
        pickerCity = UIPickerView.init()
        pickerCity.tag = 2
        pickerCity.delegate = self
        pickerCity.selectRow(0, inComponent:0, animated:true)
        
        pickerCity.backgroundColor = UIColor.white
        pickerCity.autoresizingMask = .flexibleWidth
        pickerCity.contentMode = .center
        pickerCity.setValue(UIColor.black, forKey: "textColor")
        pickerCity.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerCity)
        
        createToolbar()
    }
    
    func createProvincePicker() {
        pickerProvince = UIPickerView.init()
        pickerProvince.tag = 3
        pickerProvince.delegate = self
        pickerProvince.selectRow(0, inComponent:0, animated:true)
        
        pickerProvince.backgroundColor = UIColor.white
        pickerProvince.autoresizingMask = .flexibleWidth
        pickerProvince.contentMode = .center
        pickerProvince.setValue(UIColor.black, forKey: "textColor")
        pickerProvince.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerProvince)
        
        createToolbar()
    }
    
    private func createToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [flexibleSpace, (UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped)))]
        
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
        
        cell.cityTF.text = selectedCity
        cell.provinceTF.text = selectedProvince
        toolBar.removeFromSuperview()
        pickerStartHour.removeFromSuperview()
        pickerEndHour.removeFromSuperview()
        pickerCity.removeFromSuperview()
        pickerProvince.removeFromSuperview()
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! SetupPersonalBimbelTableViewCell
        if datePicker.tag == 0 {
            //            self.start = datePicker.date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            cell.startTF.text = timeFormatter.string(from: datePicker.date)
        } else if datePicker.tag == 1 {
            //            self.end = datePicker.date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            cell.endTF.text = timeFormatter.string(from: datePicker.date)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2{
            return ConstantManager.location.count
        }else{
            return ConstantManager.province.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2{
            return ConstantManager.location[row]
        }else{
            return ConstantManager.province[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 2{
            selectedCity = ConstantManager.location[row]
        }else{
            selectedProvince = ConstantManager.province[row]
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

