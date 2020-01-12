//
//  FilterViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    
    @IBOutlet weak var LocationCV: UICollectionView!
    @IBOutlet weak var subjectCV: UICollectionView!
    @IBOutlet weak var gradeCV: UICollectionView!
    @IBOutlet weak var minSliders: UIView!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxSlide: UISlider!
    var contentDelegate:SendLocation?
    var contDelegate:GetSelectedContent?
    var sendFilterDelegate:SendFilter?
    var salaryMin:Double?
    var salaryMax:Double?
    //Selected
    var selectMin:String?
    var selectMax:String?
    var selectedIndex:[Int] = []
    var gotIndex:[Int] = []
    var selectedLocation:[String] = []
    var selectedGrade:[String] = []
    var selectedSubject:[String] = []
    var filteredData:[(key:Int, value:String)] = ConstantManager.allSubject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        LocationCV.reloadData()
        subjectCV.reloadData()
        self.LocationCV.allowsMultipleSelection = true
        self.subjectCV.allowsMultipleSelection = true
        self.gradeCV.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        flushArray()
        reloadTable()
        setupView(text: "Filters")
        let vc = LocationViewController()
        vc.aldiDelegate = self
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func minSlider(_ sender: UISlider) {
        let minSalary = Int((roundf(sender.value)*50000))
        let myMinSalary = minSalary.formattedWithSeparator
        let maxSalary = Int((roundf(sender.value)*50000))
        let myMaxSalary = maxSalary.formattedWithSeparator
        minLabel.text = "Rp \(myMinSalary)"
        maxLabel.text = "Rp \(myMaxSalary)"
        self.salaryMin = Double(sender.value)
        self.selectMin = myMinSalary
    }
    
    @IBAction func maxSlider(_ sender: UISlider) {
        maxSlide.minimumValue = Float(Double(salaryMin ?? 0))
        let maxSalary = Int((roundf(sender.value)*50000))
        let myMaxSalary = maxSalary.formattedWithSeparator
        maxLabel.text = "Rp \(myMaxSalary)"
        self.selectMax = myMaxSalary
    }
    
    @IBAction func viewAllLocationTapped(_ sender: UIButton) {
        let locationVC = LocationViewController()
        locationVC.aldiDelegate =  self
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
    
    @IBAction func viewAllSubjectTapped(_ sender: UIButton) {
        let subjectVC = SubjectViewController()
        subjectVC.subjekDelegate = self
        self.navigationController?.pushViewController(subjectVC, animated: true)
    }
    
    @IBAction func applyTapped(_ sender: UIButton) {
        getData()
        self.sendFilterDelegate?.sendDataFilter(location: selectedLocation, minSalary: salaryMin ?? -1, maxSalary: salaryMax ?? -1, grade: selectedGrade, subject: selectedSubject)
        self.navigationController?.popViewController(animated: true)
    }
}
extension FilterViewController{
    private func flushArray() {
        selectedIndex.removeAll()
        gotIndex.removeAll()
        selectedLocation.removeAll()
        selectedGrade.removeAll()
        selectedSubject.removeAll()
    }
    
    private func reloadTable() {
        LocationCV.reloadData()
        subjectCV.reloadData()
        gradeCV.reloadData()
    }
    
    private func getData() {
        let indexLocation : [IndexPath] = (self.LocationCV!.indexPathsForSelectedItems) ?? []
        let indexGrade : [IndexPath] = self.gradeCV!.indexPathsForSelectedItems ?? []
        let indexSubject : [IndexPath] = self.subjectCV.indexPathsForSelectedItems ?? []
        
        for i in indexLocation{
            self.selectedLocation.append(ConstantManager.location[i.row])
        }
        for i in indexGrade{
            self.selectedGrade.append(ConstantManager.grade[i.row])
        }
        for i in indexSubject{
            let data = filteredData[i.row] as (key:Int,value:String)
            self.selectedSubject.append(data.value)
        }
    }
    
}
extension FilterViewController:SendLocation{
    func sendIndex(arrIndex: [Int]) {
        selectedIndex.removeAll()
        selectedIndex = arrIndex
    }
    
}
extension FilterViewController:GetSelectedContent{
    func getIndex(arrayIndex: [Int]) {
        gotIndex = arrayIndex
    }
    
}
extension FilterViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func registerCell() {
        LocationCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        gradeCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        subjectCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    private func cellDelegate() {
        LocationCV.delegate = self
        LocationCV.dataSource = self
        subjectCV.delegate = self
        subjectCV.dataSource = self
        gradeCV.delegate = self
        gradeCV.dataSource = self
    }
    
    private func reloadDataSubject(id:[Int]) {
        filteredData.removeAll()
        for i in ConstantManager.allSubject as [(key:Int, value:String)]{
            for j in id{
                if i.key == j{
                    self.filteredData.append(i)
                }
            }
        }
        self.subjectCV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.LocationCV) {
            return ConstantManager.location.count;
        }
        else if (collectionView  == subjectCV) {
            if filteredData.count == 0{
                return ConstantManager.allSubject.count
            }else{
                return filteredData.count
            }
        }else {
            return ConstantManager.grade.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.LocationCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
            
            cell.kotakFilter.layer.cornerRadius = 10
            cell.kotakFilter.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
            cell.kotakFilter.layer.borderWidth = 1
            if selectedIndex.contains(indexPath.row) {
                selectedLocation.insert(ConstantManager.location[indexPath.row], at: 0)
                cell.isSelected = true
            }
            cell.labelFilter.text = ConstantManager.location[indexPath.row]
            
            return cell
        }
        else if (collectionView == self.subjectCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
            cell.kotakFilter.layer.cornerRadius = 10
            cell.kotakFilter.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
            cell.kotakFilter.layer.borderWidth = 1
            
            if filteredData.count == 0{
                let data = ConstantManager.allSubject[indexPath.row] as (key:Int, value:String)
                cell.labelFilter.text = data.value
            }else{
                cell.labelFilter.text = filteredData[indexPath.row].value
            }
            
            if gotIndex.contains(indexPath.row){
                cell.isSelected = true
                selectedLocation.insert(ConstantManager.location[indexPath.row], at: 0)
            }
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
            cell.kotakFilter.layer.cornerRadius = 10
            cell.kotakFilter.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
            cell.kotakFilter.layer.borderWidth = 1
            cell.labelFilter.text = ConstantManager.grade[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == LocationCV{
            let label = UILabel(frame: CGRect.zero)
            label.text = ConstantManager.location[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 60, height: 44)
        }else if collectionView == subjectCV{
            let label = UILabel(frame: CGRect.zero)
            let textIndex = ConstantManager.allSubject[indexPath.item] as (key:Int, value:String)
            label.text = textIndex.value
            label.sizeToFit()
            return CGSize(width: label.frame.width + 60, height: 44)
        }else{
            let label = UILabel(frame: CGRect.zero)
            label.text = ConstantManager.grade[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 60, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == gradeCV{
            selectedIndex.insert(indexPath.row, at: 0)
            reloadDataSubject(id: selectedIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                if let index = selectedIndex.firstIndex(of: indexPath.row){
                    selectedIndex.remove(at: index)
                    reloadDataSubject(id: selectedIndex)
                }
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
    
}
