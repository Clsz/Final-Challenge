//
//  SetupLanguageViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SetupLanguageViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    var selectedLanguage: String!
    var selectedProfiency: String!
    var toolBar = UIToolbar()
    var picker = UIPickerView()
    var profiencyPicker = UIPickerView()
    var dataArray:[Any?] = []
    let hint = "HintTableViewCellID"
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    var tutor:Tutor!
    var tutors:CKRecord?
    var language:CKRecord?
    var languageReference:CKRecord.Reference!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var arrLanguage:[String] = []
    var arrProfiency:[String] = []
    var id: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Language")
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        getDataCustomCell()
        createLanguage()
    }
    
}
extension SetupLanguageViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.applyButton.loginRound()
        
    }
    
    private func setupData() {
        dataArray.removeAll()
        dataArray.append("PLEASE ADD YOUR LANGUAGE")
        dataArray.append(("Language","Choose your Language",0))
        dataArray.append(("Language Profiency","Beginner",1))
    }
    
    private func getDataCustomCell() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! AnotherDetailProfileTableViewCell
        let index1 = IndexPath(row: 2, section: 0)
        let cell1 = tableView.cellForRow(at: index1) as! AnotherDetailProfileTableViewCell
        
        self.arrLanguage.append(cell.textField.text ?? "")
        self.arrProfiency.append(cell1.textField.text ?? "")
    }
    
    private func createLanguage(){
        let newLanguage = CKRecord(recordType: "Language")
        newLanguage["languageName"] = arrLanguage
        newLanguage["languageLevel"] = arrProfiency
        
        database.save(newLanguage) { (record, error) in
            guard record != nil  else { return print("error", error as Any) }
            self.updateLanguage(recordLanguage: record!)
            
        }
        
    }
    
    
    private func updateLanguage(recordLanguage:CKRecord){
        if let record = tutors{
            record["languageID"] = CKRecord.Reference.init(recordID: recordLanguage.recordID, action: .none)
            self.database.save(record, completionHandler: {returnRecord, error in
                if error != nil{
                    self.showAlert(title: "Error", message: "Update Error")
                }else{ DispatchQueue.main.async {
                    self.sendVC()
                    }
                }
            })
        }
        
    }
    
    private func sendVC() {
        let vc = AdditionalLanguageViewController()
        vc.tutors = self.tutors
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension SetupLanguageViewController:LanguageProtocol{
    func dropLanguage() {
        self.createLanguagePicker()
    }
    
    func dropProfiency() {
        self.createProfiencyPicker()
    }
    
}
extension SetupLanguageViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
        tableView.register(UINib(nibName: "AnotherDetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: contentDrop)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let value = dataArray[indexPath.row] as? String{
            let cell = tableView.dequeueReusableCell(withIdentifier: hint, for: indexPath) as! HintTableViewCell
            cell.setCell(text: value)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String,value:String,code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.dropID = 0
                cell.languageDelegate = self
                return cell
            } else{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.dropID = 2
                cell.languageDelegate = self
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
extension SetupLanguageViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func createLanguagePicker() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.tag = 0
        picker.selectRow(5, inComponent:0, animated:true)
        
        picker.backgroundColor = UIColor.white
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        createToolbar()
        
    }
    
    func createProfiencyPicker() {
        profiencyPicker = UIPickerView.init()
        profiencyPicker.delegate = self
        profiencyPicker.selectRow(5, inComponent:0, animated:true)
        profiencyPicker.tag = 1
        profiencyPicker.backgroundColor = UIColor.white
        profiencyPicker.autoresizingMask = .flexibleWidth
        profiencyPicker.contentMode = .center
        profiencyPicker.setValue(UIColor.black, forKey: "textColor")
        profiencyPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(profiencyPicker)
        
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
        let cell = tableView.cellForRow(at: index) as! AnotherDetailProfileTableViewCell
        let index1 = IndexPath(row: 2, section: 0)
        let cell1 = tableView.cellForRow(at: index1) as! AnotherDetailProfileTableViewCell
        
        cell.textField.text = selectedLanguage
        cell1.textField.text = selectedProfiency
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        profiencyPicker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return ConstantManager.language.count
        }else{
            return ConstantManager.proficiency.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return ConstantManager.language[row]
        } else {
            return ConstantManager.proficiency[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            selectedLanguage = ConstantManager.language[row]
        } else {
            selectedProfiency = ConstantManager.proficiency[row]
        }
    }
    
}
