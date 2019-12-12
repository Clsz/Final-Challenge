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
    var selectedStartYear: String?
    var selectedEndYear: String?
    var toolBar = UIToolbar()
    var pickerStart = UIDatePicker()
    var pickerEnd = UIDatePicker()
    let content = "DetailProfileBimbelTableViewCellID"
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var bimbel:CKRecord?
    weak var delegate: LanguageViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Bimbel Personal")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}
extension DetailProfileBimbelViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(bimbel)
    }
    
    private func updateToDatabase(profileImage:UIImage, courseName:String, courseAddress:String, courseStartHour:String, courseEndHour:String) {
        
        let recordID = bimbel!.recordID
        
        database.fetch(withRecordID: recordID) { (record, error) in
            if error == nil {
                
                if let newData = profileImage.jpegData(compressionQuality: 0.00001){
                    if let data = self.createAsset(data: newData){
                        self.tempImage = data
                    }
                }
                    
                record?.setValue(self.tempImage, forKey: "courseImage")
                record?.setValue(courseName, forKey: "courseName")
                record?.setValue(courseAddress, forKey: "courseAddress")
                record?.setValue(courseStartHour, forKey: "courseStartHour")
                record?.setValue(courseEndHour, forKey: "courseEndHour")
                
                self.database.save(record!, completionHandler: { (newRecord, error) in
                    if error == nil {
                        print("Record Saved")
                    } else {
                        print("Record Not Saved")
                    }
                })
            } else {
                print("Could not fetch record")
            }
        }
        
    }
    
    private func getData() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        
        let image = (cell.profileImage.image ?? UIImage(named: ""))!
        let name = cell.nameTF.text ?? ""
        let address = cell.addressTF.text ?? ""
        let startHour = cell.startTF.text ?? ""
        let endHour = cell.endTF.text ?? ""
        
        updateToDatabase(profileImage: image, courseName: name, courseAddress: address, courseStartHour: startHour, courseEndHour: endHour)
    }
    
}
extension DetailProfileBimbelViewController:ProfileBimbelDetailProtocol, PasswordProtocol{
    func imageTapped() {
        
    }
    
    func startTapped() {
        createStartHour()
    }
    
    func endTapped() {
        createEndHour()
    }
    
    func changePassword() {
        let destVC = ChangePasswordViewController()
        destVC.bimbel = self.bimbel
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func applyProfileBimbel() {
        getData()
    }
}
extension DetailProfileBimbelViewController{
    private func createImagePicker() {
        
    }
    
    private func createStartHour() {
        pickerStart.tag = 0
        pickerStart.datePickerMode = .time
        pickerStart.backgroundColor = UIColor.white
        pickerStart.autoresizingMask = .flexibleWidth
        pickerStart.contentMode = .center
        pickerStart.setValue(UIColor.black, forKey: "textColor")
        pickerStart.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerStart)
        pickerStart.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        
        createToolbar()
    }

    private func createEndHour() {
        pickerEnd.tag = 1
        pickerEnd.backgroundColor = UIColor.white
        pickerEnd.datePickerMode = .time
        pickerEnd.autoresizingMask = .flexibleWidth
        pickerEnd.contentMode = .center
        pickerEnd.setValue(UIColor.black, forKey: "textColor")
        pickerEnd.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerEnd)
        pickerEnd.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        
        createToolbar()
    }
    
    private func createToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerStart.removeFromSuperview()
        pickerEnd.removeFromSuperview()
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        
        if datePicker == pickerStart{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm a"
            cell.startTF.text = dateFormater.string(from: datePicker.date)
        }else{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm a"
            
            cell.endTF.text = dateFormater.string(from: datePicker.date)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileBimbelTableViewCell
        cell.setInterface()
        cell.passwordDelegate = self
        cell.delegate = self
        cell.view = self.view
        
        return cell
    }
}

