//
//  SetupEducationViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SetupEducationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    var selectedEducation: String!
    var selectedStartYear: String?
    var selectedEndYear: String?
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var pickerStart = UIPickerView()
    var pickerEnd = UIPickerView()
    var dataArray:[Any?] = []
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    let contentDate = "MoreDetailTableViewCellID"
    var tutors:CKRecord?
    var education:CKRecord?
    var educationReference:CKRecord.Reference!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    lazy var additionalEducation = AdditionalEducationViewController()
    
    var arrStart:[String] = []
    var arrEnd:[String] = []
    var arrSchoolName:[String] = []
    var arrGrade:[String] = []
    var arrFOS:[String] = []
    var arrGPA:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        registerCell()
        cellDelegate()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeContentCustom()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        getDataCustomCell()
        createEducation()
    }
    
}
extension SetupEducationViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.applyButton.loginRound()
        setupView(text: "Education")
    }
    
    private func setupData() {
        dataArray.removeAll()
        dataArray.append(("School","Enter your School Name",0))
        dataArray.append(("Education Type","High School",1))
        dataArray.append(("Field of Study","Enter your Field of Study",0))
        dataArray.append(("GPA","Enter your Scores",0))
        dataArray.append(true)
    }
    
    private func getDataCustomCell() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileTableViewCell
        let index1 = IndexPath(row: 1, section: 0)
        let cell1 = tableView.cellForRow(at: index1) as! AnotherDetailProfileTableViewCell
        let index2 = IndexPath(row: 2, section: 0)
        let cell2 = tableView.cellForRow(at: index2) as! DetailProfileTableViewCell
        let index3 = IndexPath(row: 3, section: 0)
        let cell3 = tableView.cellForRow(at: index3) as! DetailProfileTableViewCell
        let index4 = IndexPath(row: 4, section: 0)
        let cell4 = tableView.cellForRow(at: index4) as! MoreDetailTableViewCell
        
        self.arrStart.append(cell4.startTF.text ?? "")
        self.arrEnd.append(cell4.endTF.text ?? "")
        self.arrSchoolName.append(cell.textField.text ?? "")
        self.arrGrade.append(cell1.textField.text ?? "")
        self.arrFOS.append(cell2.textField.text ?? "")
        self.arrGPA.append(cell3.textField.text ?? "")
    }
    
    private func createEducation(){
        let newEducation = CKRecord(recordType: "Education")
        newEducation["schoolName"] = arrSchoolName
        newEducation["grade"] = arrGrade
        newEducation["fieldOfStudy"] = arrFOS
        newEducation["gpa"] = arrGPA
        newEducation["startYear"] = arrStart
        newEducation["endYear"] = arrEnd
        
        database.save(newEducation) { (record, error) in
            guard record != nil  else { return print("error", error as Any) }
            self.updateEducation(recordEducation: record!)
        }
        
    }
    
    
    private func updateEducation(recordEducation:CKRecord){
        if let record = tutors{
            record["educationID"] = CKRecord.Reference.init(recordID: recordEducation.recordID, action: .none)
            self.database.save(record, completionHandler: {returnRecord, error in
                if error != nil{
                    self.showAlert(title: "Error", message: "Update Error")
                }
                DispatchQueue.main.async {
                    self.sendVC()
                }
            })
        }
        
    }
    
    private func sendVC() {
        additionalEducation.tutors = self.tutors
        self.navigationController?.pushViewController(additionalEducation, animated: true)
    }
    
    //    private func checkData() {
    //        let index = IndexPath(row: 0, section: 0)
    //        let cell = tableView.cellForRow(at: index) as! DetailProfileTableViewCell
    //        let index1 = IndexPath(row: 1, section: 0)
    //        let cell1 = tableView.cellForRow(at: index1) as! AnotherDetailProfileTableViewCell
    //        let index2 = IndexPath(row: 2, section: 0)
    //        let cell2 = tableView.cellForRow(at: index2) as! DetailProfileTableViewCell
    //        let index3 = IndexPath(row: 3, section: 0)
    //        let cell3 = tableView.cellForRow(at: index3) as! DetailProfileTableViewCell
    //        let index4 = IndexPath(row: 4, section: 0)
    //        let cell4 = tableView.cellForRow(at: index4) as! MoreDetailTableViewCell
    //
    //        if cell.textField.text == "" || cell1.textField.text == "" || cell2.textField.text == "" || cell3.textField.text == "" || cell4.startTF.text == "" || cell4.endTF.text == "" {
    //            applyButton.isEnabled = false
    //            applyButton.backgroundColor = #colorLiteral(red: 0.6070619822, green: 0.6075353622, blue: 0.6215403676, alpha: 0.8470588235)
    //        }else{
    //            applyButton.isEnabled = true
    //            applyButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
    //        }
    //    }
    
}
extension SetupEducationViewController:EducationProtocol{
    func dropEducation() {
        self.createSchoolPicker()
    }
    
    func startTapped() {
        self.createStartDate()
    }
    
    func endTapped() {
        self.createEndDate()
    }
    
}
extension SetupEducationViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "DetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: content)
        tableView.register(UINib(nibName: "AnotherDetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: contentDrop)
        tableView.register(UINib(nibName: "MoreDetailTableViewCell", bundle: nil), forCellReuseIdentifier: contentDate)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let keyValue = dataArray[indexPath.row] as? (key:String,value:String,code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.view = self.view
                //                checkData()
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.dropID = 1
                cell.educationDelegate = self
                //                checkData()
                return cell
            }
        }
        else if let _ = dataArray[indexPath.row] as? Bool{
            let cell = tableView.dequeueReusableCell(withIdentifier: contentDate, for: indexPath) as! MoreDetailTableViewCell
            cell.setCell(startText: "Start Year", endText: "End Year", buttStart: "", buttEnd: "")
            cell.educationDelegate = self
            //            checkData()
            return cell
        }
        return UITableViewCell()
    }
    
}
extension SetupEducationViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func createSchoolPicker() {
        picker = UIPickerView.init()
        picker.tag = 0
        picker.delegate = self
        picker.selectRow(5, inComponent:0, animated:true)
        
        picker.backgroundColor = UIColor.white
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        createToolbar()
    }
    
    private func createStartDate() {
        pickerStart = UIPickerView.init()
        pickerStart.tag = 1
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
    
    private func createEndDate() {
        pickerEnd = UIPickerView.init()
        pickerEnd.tag = 2
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
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [flexibleSpace, (UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped)))]
        
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        let index1 = IndexPath(row: 1, section: 0)
        let cell1 = tableView.cellForRow(at: index1) as! AnotherDetailProfileTableViewCell
        let index4 = IndexPath(row: 4, section: 0)
        let cell4 = tableView.cellForRow(at: index4) as! MoreDetailTableViewCell
        
        cell1.textField.text = selectedEducation
        cell4.startTF.text = selectedStartYear
        cell4.endTF.text = selectedEndYear
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        pickerStart.removeFromSuperview()
        pickerEnd.removeFromSuperview()
        //        checkData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return ConstantManager.educationType.count
        }else if pickerView.tag == 1{
            return ConstantManager.year.count
        }else{
            return ConstantManager.year.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return ConstantManager.educationType[row]
        }else if pickerView.tag == 1{
            return ConstantManager.year[row]
        }else{
            return ConstantManager.year[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            selectedEducation = ConstantManager.educationType[row]
        }else if pickerView.tag == 1{
            selectedStartYear = ConstantManager.year[row]
        }else{
            selectedEndYear = ConstantManager.year[row]
        }
    }
    
    private func removeContentCustom() {
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! DetailProfileTableViewCell
        let index1 = IndexPath(row: 1, section: 0)
        let cell1 = tableView.cellForRow(at: index1) as! AnotherDetailProfileTableViewCell
        let index2 = IndexPath(row: 2, section: 0)
        let cell2 = tableView.cellForRow(at: index2) as! DetailProfileTableViewCell
        let index3 = IndexPath(row: 3, section: 0)
        let cell3 = tableView.cellForRow(at: index3) as! DetailProfileTableViewCell
        let index4 = IndexPath(row: 4, section: 0)
        let cell4 = tableView.cellForRow(at: index4) as! MoreDetailTableViewCell
        
        cell4.startTF.text = ""
        cell4.endTF.text = ""
        cell.textField.text = ""
        cell2.textField.text  = ""
        cell3.textField.text = ""
        cell1.textField.text = ""
    }
}
