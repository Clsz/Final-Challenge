//
//  SetupLanguageViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupLanguageViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    var selectedMonth: String!
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var dataArray:[Any?] = []
    let hint = "HintTableViewCellID"
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    var tutor:Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Language Setup")
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
    @IBAction func skipTapped(_ sender: Any) {
    }
    
}
extension SetupLanguageViewController{
    private func setMainInterface() {
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.applyButton.loginRound()
       
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append("PLEASE ADD YOUR LANGUAGE")
        dataArray.append(("Language","Enter your Language",0))
        dataArray.append(("Language Proficiency","Beginner",1))
    }
    
}

extension SetupLanguageViewController:LanguageProtocol{
    func dropLanguage() {
        self.createLanguagePicker()
    }
    
}
extension SetupLanguageViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
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
        if let value = dataArray[indexPath.row] as? String{
            let cell = tableView.dequeueReusableCell(withIdentifier: hint, for: indexPath) as! HintTableViewCell
            cell.setCell(text: value)
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String,value:String,code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                cell.dropID = 0
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
        picker.selectRow(5, inComponent:0, animated:true)

        picker.backgroundColor = UIColor.white
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        createToolbar()
        
    }
    
    private func createToolbar() {
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
        return ConstantManager.proficiency.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ConstantManager.proficiency[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMonth = ConstantManager.proficiency[row]
    }
}
