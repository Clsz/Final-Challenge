//
//  SetupEducationViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupEducationViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    var selectedEducation: String!
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var dataArray:[Any?] = []
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    var tutor:Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        
    }
    
}
extension SetupEducationViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.applyButton.loginRound()
        setupView(text: "Education Setup")
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(("School","Enter your School Name",0))
        dataArray.append(("Education Type","Senior High School",1))
        dataArray.append(("Field of Study","Enter your Field of Study",0))
        dataArray.append(("Grade","Enter your Grade",0))
    }
}
extension SetupEducationViewController:EducationProtocol{
    func dropEducation() {
        self.createSchoolPicker()
    }
    
}
extension SetupEducationViewController:UITableViewDataSource,UITableViewDelegate{
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
extension SetupEducationViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
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
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
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

