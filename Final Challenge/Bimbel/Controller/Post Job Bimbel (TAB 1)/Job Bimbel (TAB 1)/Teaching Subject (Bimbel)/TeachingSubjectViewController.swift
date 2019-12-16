//
//  TeachingSubjectViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 04/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingSubjectViewController: BaseViewController{

    @IBOutlet weak var tableViewTS: UITableView!
    @IBOutlet weak var btnApplySubject: UIButton!
    var selectedSubject:[String] = []
    let cellJob = "locationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Subject")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func applySubjectTapped(_ sender: UIButton) {
        let lastVC = JobDetailsViewController()
        lastVC.arraySubject = self.selectedSubject
        
        let destVC = TeachingGradeViewController()
        destVC.jobDetailVC = lastVC
        
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension TeachingSubjectViewController: UITableViewDelegate, UITableViewDataSource{
    private func registerCell() {
        self.tableViewTS.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: cellJob)
    }
    
    private func cellDelegate() {
        self.tableViewTS.dataSource = self
        self.tableViewTS.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConstantManager.allSubject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTS.dequeueReusableCell(withIdentifier: cellJob, for: indexPath) as! LocationTableViewCell
        cell.selectionStyle = .none
        let data:(key:Int, value:String) = ConstantManager.allSubject[indexPath.row]
        cell.lokasiLabel.text = data.value
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


