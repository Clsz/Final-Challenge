//
//  SetupSubjectBimbelViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 16/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SetupSubjectBimbelViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    let subjectCell = "subjekCell"
    let filterCell = "filterCell"
    var selectedGrade:[String] = []
    var selectedSubject:[String] = []
    var selectedIndex:[Int] = []
    var sel:[String] = [String]()
    var filteredData:[(key:Int, value:String)] = ConstantManager.allSubject
    var course:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
        registerCellCV()
        cellDelegateCV()
        registerCell()
        cellDelegate()
        self.collectionView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Subject")
    }
    
    
    @IBAction func applyTapped(_ sender: UIButton) {
        updatePreferences()
    }
    
    
}

extension SetupSubjectBimbelViewController{
    func setUpView(){
        tableView.outerRound()
        applyButton.outerRound()
    }
    
    func updatePreferences(){
        if let record = course{
            record["courseGrade"] = selectedGrade
            record["courseSubject"] = selectedSubject
            
            self.database.save(record, completionHandler: {returnRecord, error in
                if error != nil
                {
                    self.showAlert(title: "Error", message: "Update Error")
                } else{
                    DispatchQueue.main.async {
                        let destVC = SummarySetupBimbelViewController()
                        destVC.course = self.course
                        self.navigationController?.pushViewController(destVC, animated: true)
                    }
                }
            })
        }
    }
    
}

extension SetupSubjectBimbelViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func registerCellCV() {
        collectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
    }
    
    private func cellDelegateCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
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
        self.tableView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConstantManager.grade.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
        cell.labelFilter.text = ConstantManager.grade[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex.insert(indexPath.row, at: 0)
        selectedGrade.insert(ConstantManager.grade[indexPath.row], at: 0)
        reloadDataSubject(id: selectedIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                if let index = selectedIndex.firstIndex(of: indexPath.row){
                    selectedIndex.remove(at: index)
                    selectedGrade.remove(at: index)
                    reloadDataSubject(id: selectedIndex)
                }
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        return true
    }
    
}

extension SetupSubjectBimbelViewController: UITableViewDataSource, UITableViewDelegate{
    func cellDelegate(){
        tableView.dataSource =  self
        tableView.delegate = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "SubjectTableViewCell", bundle: nil), forCellReuseIdentifier: subjectCell)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.count == 0{
            return ConstantManager.allSubject.count
        }else{
            return filteredData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: subjectCell, for: indexPath) as! SubjectTableViewCell
        
        cell.selectionStyle = .none
        
        if filteredData.count == 0{
            let data = ConstantManager.allSubject[indexPath.row] as (key:Int, value:String)
            cell.namaSubjek.text = data.value
        }else{
            cell.namaSubjek.text = filteredData[indexPath.row].value
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            let data:(key:Int, value:String) = ConstantManager.allSubject[indexPath.row]
            selectedSubject.insert(data.value, at: 0)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        let data:(key:Int, value:String) = ConstantManager.allSubject[indexPath.row]
        if let index = selectedSubject.firstIndex(of: data.value) {
            selectedSubject.remove(at: index)
        }
    }
    
    
    
}
