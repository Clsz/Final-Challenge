//
//  EducationViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class EducationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    var selectedEducation: String!
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var dataArray:[Any?] = []
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    var tutor:Tutor!
    weak var delegate: LanguageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.refreshData(withTutorModel: tutor)
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        getData()
    }
    
}
extension EducationViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.applyButton.loginRound()
        self.outerView.outerRound()
        setupView(text: "Pendidikan")
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(("Sekolah","Masukkan nama sekolah kamu",0))
        dataArray.append(("Tingkat Pendidikan","Sekolah Menengah Atas",1))
        dataArray.append(("Jurusan","Masukkan jurusan kamu",0))
        dataArray.append(("Semester","Masukkan semester kamu",0))
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
        
    }
    
}
extension EducationViewController:EducationProtocol{
    func startTapped() {
        return
    }
    
    func endTapped() {
        return 
    }
    
    func dropEducation() {
        self.createSchoolPicker()
    }
    
}
extension EducationViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "DetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: content)
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
        if let keyValue = dataArray[indexPath.row] as? (key:String,value:String,code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.view = self.view
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.dropID = 1
                cell.educationDelegate = self
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
extension EducationViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func createSchoolPicker() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.selectRow(5, inComponent:0, animated:true)
        
        picker.backgroundColor = UIColor.white
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Selesai", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: index) as! AnotherDetailProfileTableViewCell
        
        cell.textField.text = selectedEducation
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ConstantManager.educationType.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ConstantManager.educationType[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEducation = ConstantManager.educationType[row]
    }
}
