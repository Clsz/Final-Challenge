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
    var selectedStartYear: String?
    var selectedEndYear: String?
    var toolBar = UIToolbar()
    var pickerStart = UIPickerView()
    var pickerEnd = UIPickerView()
    let content = "DetailProfileBimbelTableViewCellID"
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
    
    private func saveToDatabase() {
        
    }
    
    private func getData() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        
        let image = cell.profileImage.image
        let name = cell.nameTF.text
        let address = cell.addressTF.text
        let startHour = cell.startTF.text
        let endHour = cell.endTF.text
        
        //Save here later
    }
    
    
    
}
extension DetailProfileBimbelViewController:ProfileBimbelDetailProtocol, PasswordProtocol{
    func startTapped() {
        createStartHour()
    }
    
    func endTapped() {
        createEndHour()
    }
    
    func changePassword() {
        let destVC = ChangePasswordViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func applyProfileBimbel() {
        // Panggil get data and save
    }
}
extension DetailProfileBimbelViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
    private func createStartHour() {
        pickerStart = UIPickerView.init()
        pickerStart.tag = 0
        pickerStart.delegate = self
        pickerStart.selectRow(5, inComponent:0, animated:true)
        
        pickerStart.backgroundColor = UIColor.white
        pickerStart.autoresizingMask = .flexibleWidth
        pickerStart.contentMode = .center
        pickerStart.setValue(UIColor.black, forKey: "textColor")
        pickerStart.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerStart)
        
        createToolbar()
    }
    
    private func createEndHour() {
        pickerEnd = UIPickerView.init()
        pickerEnd.tag = 1
        pickerEnd.delegate = self
        pickerEnd.selectRow(5, inComponent:0, animated:true)
        
        pickerEnd.backgroundColor = UIColor.white
        pickerEnd.autoresizingMask = .flexibleWidth
        pickerEnd.contentMode = .center
        pickerEnd.setValue(UIColor.black, forKey: "textColor")
        pickerEnd.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerEnd)
        
        createToolbar()
    }
    
    private func createToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileBimbelTableViewCell
        cell.startTF.text = selectedStartYear
        cell.endTF.text = selectedEndYear
        
        toolBar.removeFromSuperview()
        pickerStart.removeFromSuperview()
        pickerEnd.removeFromSuperview()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return ConstantManager.year.count
        }else{
            return ConstantManager.year.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return ConstantManager.year[row]
        }else {
            return ConstantManager.year[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            selectedStartYear = ConstantManager.year[row]
        }else{
            selectedEndYear = ConstantManager.year[row]
        }
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
//        cell.setCell(nameText: (bimbel?.value(forKey: "courseName") as! String) ?? "", addressText: (bimbel?.value(forKey: "courseAddress") as! String) ?? "", start: (bimbel?.value(forKey: "courseStartHour") as! String) ?? "", end: (bimbel?.value(forKey: "courseEndHour") as! String) ?? "")
        
        
        
        return cell
    }
}
