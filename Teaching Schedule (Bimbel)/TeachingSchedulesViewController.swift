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
    
    
    var contentDelegate:sendLocation?
    var contDelegate:SubjectProtocol?
    var selectedIndex:[Int] = []
    var selectedDays:[String] = []
    var toolBar = UIToolbar()
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var selectedStartYear: String?
    var selectedEndYear: String?
    var pickerStart = UIDatePicker()
    var pickerEnd = UIDatePicker()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        daysCV.delegate = self
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
        //PROTOCOL
    }
    
}

extension TeachingSchedulesViewController{
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConstantManager.day.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        
        
        cell.kotakFilter.layer.cornerRadius = 10
        cell.kotakFilter.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        cell.kotakFilter.layer.borderWidth = 1
        if selectedIndex.contains(indexPath.row) {
            selectedDays.insert(ConstantManager.day[indexPath.row], at: 0)
            cell.isSelected = true
        }
        cell.labelFilter.text = ConstantManager.day[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 44)
    }
    
    func cellDelegate() {
        daysCV.delegate = self
        daysCV.dataSource = self
    }
    
    func registerCell() {
        daysCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //Append data days yang di select ke dalam array
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
