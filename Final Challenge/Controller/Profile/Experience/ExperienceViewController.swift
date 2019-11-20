//
//  ExperienceViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ExperienceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    var dataArray:[Any?] = []
    var selectedExperience: String?
    var selectedStartYear: String?
    var selectedEndYear: String?
    var toolBar = UIToolbar()
    var pickerExperience  = UIPickerView()
    var pickerStart = UIPickerView()
    var pickerEnd = UIPickerView()
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    let contentDate = "MoreDetailTableViewCellID"
    let footer = "FooterTableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Pengalaman")
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        getData()
    }
}
extension ExperienceViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.outerView.outerRound()
        self.applyButton.loginRound()
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(("Judul","Contoh: iOS Developer",0))
        dataArray.append(("Tipe Pengalaman","PartTime",1))
        dataArray.append(("Perusahaan","Contoh: Apple Developer Academy",0))
        dataArray.append(("Lokasi","Masukkan lokasi kamu bekerja",0))
        dataArray.append(true)
    }
    
    private func getData() {
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
        
        experience = Experience(cell.textField.text ?? "", cell1.textField.text ?? "", cell2.textField.text ?? "", cell3.textField.text ?? "",cell4.startTF.text ?? "" , cell4.endTF.text ?? "")
        tutor.tutorExperience.append(experience!)
        showAlert(title: "Berhasil", message: "Pengalaman anda telah diperbaruhi")
    }
    
}
extension ExperienceViewController:ExperienceProtocol{
    func startTapped() {
        createStartDate()
    }
    
    func endTapped() {
        createEndDate()
    }
    
    func dropExperience() {
        createExperienceType()
    }
    
}
extension ExperienceViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
    private func createExperienceType() {
        pickerExperience = UIPickerView.init()
        pickerExperience.tag = 0
        pickerExperience.delegate = self
        pickerExperience.selectRow(5, inComponent:0, animated:true)
        
        pickerExperience.backgroundColor = UIColor.white
        pickerExperience.autoresizingMask = .flexibleWidth
        pickerExperience.contentMode = .center
        pickerExperience.setValue(UIColor.black, forKey: "textColor")
        pickerExperience.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerExperience)
        
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
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Selesai", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! AnotherDetailProfileTableViewCell
        let index4 = IndexPath(row: 4, section: 0)
        let cell4 = tableView.cellForRow(at: index4) as! MoreDetailTableViewCell
        
        cell.textField.text = selectedExperience
        cell4.startTF.text = selectedStartYear
        cell4.endTF.text = selectedEndYear
        toolBar.removeFromSuperview()
        pickerExperience.removeFromSuperview()
        pickerStart.removeFromSuperview()
        pickerEnd.removeFromSuperview()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return ConstantManager.experienceType.count
        }else if pickerView.tag == 1{
            return ConstantManager.year.count
        }else{
            return ConstantManager.year.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return ConstantManager.experienceType[row]
        }else if pickerView.tag == 1{
            return ConstantManager.year[row]
        }else{
            return ConstantManager.year[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            selectedExperience = ConstantManager.experienceType[row]
        }else if pickerView.tag == 1{
            selectedStartYear = ConstantManager.year[row]
        }else{
            selectedEndYear = ConstantManager.year[row]
        }
    }
}
extension ExperienceViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "DetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: content)
        tableView.register(UINib(nibName: "AnotherDetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: contentDrop)
        tableView.register(UINib(nibName: "MoreDetailTableViewCell", bundle: nil), forCellReuseIdentifier: contentDate)
        tableView.register(UINib(nibName: "ProfileFooterViewCell", bundle: nil), forCellReuseIdentifier: "ProfileFooterViewCell")
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
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.dropID = 2
                cell.experienceDelegate = self
                return cell
            }
        }else if let _ = dataArray[indexPath.row] as? Bool{
            let cell = tableView.dequeueReusableCell(withIdentifier: contentDate, for: indexPath) as! MoreDetailTableViewCell
            cell.setCell(startText: "Tahun Mulai", endText: "Tahun Selesai", buttStart: "", buttEnd: "")
            cell.dateDelegate = self
            return cell
        }
        return UITableViewCell()
    }
}
