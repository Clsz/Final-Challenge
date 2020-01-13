//
//  DetailProfileBimbelViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class DetailProfileBimbelViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    var tempImage:CKAsset?
    var selectedCity: String?
    var selectedProvince: String?
    var selectedStartYear: String?
    var selectedEndYear: String?
    var toolBar = UIToolbar()
    var pickerStartHour = UIDatePicker()
    var pickerEndHour = UIDatePicker()
    var pickerCity = UIPickerView()
    var pickerProvince = UIPickerView()
    var photoPicker = UIImagePickerController()
    let content = "DetailProfileBimbelTableViewCellID"
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var course:CKRecord?
    weak var delegate: LanguageViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Tuition Personal")
        setupData()
        registerCell()
        cellDelegate()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
extension DetailProfileBimbelViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(course)
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
    
    func updateUser(name:String, address:String, startHour:String, endHour:String, city:String, province:String, completion: @escaping (Bool) -> Void){
        
        if let record = course{
            let index = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
            
            let tempImg = course?["courseImage"]  as?  CKAsset
            cell.profileImage.image =  tempImg?.toUIImage()
            
            let newImageData = cell.profileImage.image?.jpegData(compressionQuality: 0.00000000000000001)
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
                    self.navigationController?.popViewController(animated: true)
                }
                
            })
        }
    }
    
    private func getDataCustomCell() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        
        
        self.updateUser(name: cell.nameTF.text ?? "", address: cell.addressTF.text ?? "", startHour: cell.startTF.text ?? "", endHour: cell.endTF.text ?? "", city: cell.cityTF.text ?? "", province: cell.provinceTF.text ?? "") { (res) in
            if res == true{
                
            }
        }
    }
    
}
extension DetailProfileBimbelViewController:ProfileBimbelDetailProtocol, PasswordProtocol, AddressProtocol{
    func cityTapped() {
        createCityPicker()
    }
    
    func provinceTapped() {
        createProvincePicker()
    }
    
    func imageTapped() {
        createImagePicker()
    }
    
    func startTapped() {
        createStartHour()
    }
    
    func endTapped() {
        createEndHour()
    }
    
    func changePassword() {
        let destVC = ChangePasswordViewController()
        destVC.course = self.course
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func applyProfileBimbel() {
        self.showLoading()
        getDataCustomCell()
    }
    
}
extension DetailProfileBimbelViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "DetailProfileBimbelTableViewCell", bundle: nil), forCellReuseIdentifier: content)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ((course?.value(forKey: "courseName") != nil) && (course?.value(forKey: "courseAddress") != nil) && (course?.value(forKey: "courseCity") != nil) && (course?.value(forKey: "courseProvince") != nil) && (course?.value(forKey: "courseStartHour") != nil) && (course?.value(forKey: "courseEndHour") != nil)){
            let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileBimbelTableViewCell
            let name = course?.value(forKey: "courseName") as! String
            let address = course?.value(forKey: "courseAddress") as! String
            let startHour = course?.value(forKey: "courseStartHour") as! String
            let endHour = course?.value(forKey: "courseEndHour") as! String
            let city = course?.value(forKey: "courseCity") as! String
            let province = course?.value(forKey: "courseProvince") as! String
            
            cell.setCell(nameText: name, addressText: address, start: startHour, end: endHour, city: city, province: province)
            cell.passwordDelegate = self
            cell.delegate = self
            cell.addressDelegate = self
            cell.view = self.view
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileBimbelTableViewCell
            cell.setCell(nameText: "", addressText: "", start: "", end: "", city: "", province: "")
            cell.passwordDelegate = self
            cell.delegate = self
            cell.addressDelegate = self
            cell.view = self.view
            return cell
        }
        
    }
}
extension DetailProfileBimbelViewController:UIPickerViewDelegate, UIPickerViewDataSource{
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
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        
        cell.cityTF.text = selectedCity
        cell.provinceTF.text = selectedProvince
        toolBar.removeFromSuperview()
        pickerStartHour.removeFromSuperview()
        pickerEndHour.removeFromSuperview()
        pickerCity.removeFromSuperview()
        pickerProvince.removeFromSuperview()
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
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
extension DetailProfileBimbelViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            cell.profileImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
