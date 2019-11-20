//
//  FilterViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    
    var salaryMin: Double?
    var selectedIndex:[Int] = []
    var contentDelegate:AldiProtocol?
    var contDelegate:SubjectProtocol?
    
    let grade = [
        "PAUD",
        "TK",
        "SD",
        "SMP",
        "SMA",
        "Kuliah"
    ]
    
    
    @IBOutlet weak var LocationCV: UICollectionView!
    @IBOutlet weak var subjectCV: UICollectionView!
    @IBOutlet weak var gradeCV: UICollectionView!
    
    @IBOutlet weak var minSliders: UIView!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxSlide: UISlider!
    
    
    @IBAction func minSlider(_ sender: UISlider) {
        let minSalary = Int((roundf(sender.value)*50000))
        let myMinSalary = minSalary.formattedWithSeparator
        let maxSalary = Int((roundf(sender.value)*50000))
        let myMaxSalary = maxSalary.formattedWithSeparator
        minLabel.text = "Rp \(myMinSalary)"
        maxLabel.text = "Rp \(myMaxSalary)"
        salaryMin = Double(sender.value)
    }
    
    @IBAction func maxSlider(_ sender: UISlider) {
        maxSlide.minimumValue = Float(Double(salaryMin ?? 0))
        let maxSalary = Int((roundf(sender.value)*50000))
        let myMaxSalary = maxSalary.formattedWithSeparator
        maxLabel.text = "Rp \(myMaxSalary)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LocationCV.delegate = self
        registerCell()
        cellDelegate()
        
        LocationCV.reloadData()
        subjectCV.reloadData()
        self.LocationCV.allowsMultipleSelection = true
        self.subjectCV.allowsMultipleSelection = true
        self.gradeCV.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = LocationViewController()
        vc.aldiDelegate = self
        
//        let vc2 = SubjectViewController()
//        vc2.subjekDelegate = self
        
        LocationCV.reloadData()
        subjectCV.reloadData()
        setupView(text: "Filter")
//        for i in 0..<selectedIndex.count {
//            let index = IndexPath(row: i, section: 0)
//            let cell = LocationCV.cellForItem(at: index)
//            cell?.isSelected = true
//        }

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
        
    }
}

extension FilterViewController:AldiProtocol{
    func sendIndex(arrIndex: [Int]) {
        selectedIndex = arrIndex
    }
}

extension FilterViewController:SubjectProtocol{
    func sendIndexs(arrIndex: [Int]) {
        selectedIndex = arrIndex
    }
}

extension FilterViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.LocationCV) {
            return ConstantManager.tempArray.count;
        }
        else if (collectionView  == subjectCV) {
            return  ConstantManager.tempArraySubject.count
        }
        else {
            return grade.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.LocationCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
            
            if selectedIndex.contains(indexPath.row) {
                cell.isSelected = true
            }
            cell.labelFilter.text = ConstantManager.tempArray[indexPath.row]
            
            
            return cell
        }
        else if (collectionView  == subjectCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
            
            if selectedIndex.contains(indexPath.row) {
                           cell.isSelected = true
                       }
            cell.labelFilter.text = ConstantManager.tempArraySubject[indexPath.row]
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
            
            cell.setView()
            cell.labelFilter.text = grade[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
    func cellDelegate() {
        LocationCV.delegate = self
        LocationCV.dataSource = self
        subjectCV.delegate = self
        subjectCV.dataSource = self
        gradeCV.delegate = self
        gradeCV.dataSource = self
    }
    
    func registerCell() {
        LocationCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        subjectCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        gradeCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
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
