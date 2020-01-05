//
//  TeachingSchedulesViewController.swift
//  Final Challenge
//
//  Created by jefri on 05/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingSchedulesViewController: BaseViewController {
    
    
    @IBOutlet weak var daysCV: UICollectionView!
    @IBOutlet weak var startTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    var toolBar = UIToolbar()
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var selectedStart: [String] = []
    var selectedEnd: [String] = []
    var selectedDays:[String] = []
    var currentSelected:[String] = []
    var combinedDays:String = ""
    var pickerStart = UIDatePicker()
    var pickerEnd = UIDatePicker()
    var sendSchedule:SendSchedule?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        registerCell()
        cellDelegate()
        daysCV.reloadData()
        self.daysCV.allowsMultipleSelection = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Schedule")
    }
    
    func setInterface() {
        self.startTF.layer.borderWidth = 1.0
        self.endTF.layer.borderWidth = 1.0
        self.startTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.endTF.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.startTF.setLeftPaddingPoints(10.0)
        self.endTF.setLeftPaddingPoints(10.0)
        self.startTF.outerRound()
        self.endTF.outerRound()
        self.applyButton.outerRound()
        
    }
    @IBAction func startTapped(_ sender: Any) {
        createStartHour()
    }
    
    @IBAction func endTapped(_ sender: Any) {
        createEndHour()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        if daysCV.indexPathsForSelectedItems?.count != 0 && startTF.text?.isEmpty == false && endTF.text?.isEmpty == false{
            getAllData()
            sendSchedule?.sendTeachingSchedule(day: selectedDays, startHour: selectedStart, endHour: selectedEnd)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension TeachingSchedulesViewController{
    private func getAllData() {
        if let data = daysCV.indexPathsForSelectedItems{
            for i in data{
                currentSelected.append(ConstantManager.day[i.row])
            }
        }
        for i in  0..<currentSelected.count{
            if i == 0{
                combinedDays += currentSelected[i]
            }else { combinedDays += ", \(currentSelected[i])" }
            
        }
        
        self.selectedDays.append(combinedDays)
        self.selectedStart.append(startTF.text ?? "")
        self.selectedEnd.append(endTF.text ?? "")
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
        
        if datePicker == pickerStart{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            startTF.text = dateFormater.string(from: datePicker.date)
        }else{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            endTF.text = dateFormater.string(from: datePicker.date)
        }
    }
}
extension TeachingSchedulesViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func registerCell() {
        daysCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    private func cellDelegate() {
        daysCV.delegate = self
        daysCV.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConstantManager.day.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        cell.kotakFilter.layer.cornerRadius = 10
        cell.kotakFilter.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        cell.kotakFilter.layer.borderWidth = 1
        cell.labelFilter.text = ConstantManager.day[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
}

extension TeachingSchedulesViewController:UITextFieldDelegate{
    private func doneButton() {
        self.accessoryDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        self.startTF.inputAccessoryView  = accessoryToolBar
        self.endTF.inputAccessoryView = accessoryToolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
}
