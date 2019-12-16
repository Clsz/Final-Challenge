//
//  TeachingGradeViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 04/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingGradeViewController: BaseViewController {
    
    //Table View Teaching Grade
    @IBOutlet weak var tableViewTG: UITableView!
    let cellJob = "locationCell"
    var selectedGrade:[String] = []
    lazy var jobDetailVC = JobDetailsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Grade")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func applyGradeTapped(_ sender: Any) {
        jobDetailVC.arrayGrade = ["Kindergarten"]
        
        let destVC = JobInformationViewController()
        destVC.jobDetailVC = self.jobDetailVC
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension TeachingGradeViewController: UITableViewDelegate, UITableViewDataSource{
    private func registerCell() {
        self.tableViewTG.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: cellJob)
    }
    
    private func cellDelegate() {
        self.tableViewTG.dataSource = self
        self.tableViewTG.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConstantManager.grade.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTG.dequeueReusableCell(withIdentifier: cellJob, for: indexPath) as! LocationTableViewCell
        
        cell.selectionStyle = .none
        
        cell.lokasiLabel.text = ConstantManager.grade[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
    }
    
    
}
