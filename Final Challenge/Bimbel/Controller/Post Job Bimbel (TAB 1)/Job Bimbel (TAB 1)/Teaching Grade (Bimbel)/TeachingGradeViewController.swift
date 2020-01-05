//
//  TeachingGradeViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 04/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingGradeViewController: BaseViewController {
    
    @IBOutlet weak var progressView1: UIView!
    @IBOutlet weak var progressView2: UIView!
    @IBOutlet weak var progressView3: UIView!
    @IBOutlet weak var progressView4: UIView!
    @IBOutlet weak var tableViewTG: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    let cellJob = "locationCell"
    var selectedGrade:[String] = []
    lazy var jobDetailVC = JobDetailsViewController()
    var flag:Bool = true
    var delegate:passDataToDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Grade")
        setMainInterface()
        checkData()
    }
    
    
    @IBAction func applyGradeTapped(_ sender: Any) {
        if flag == false{
            delegate?.passDataGrade(dataGrade: selectedGrade)
            self.navigationController?.popViewController(animated: true)
        }else{
            jobDetailVC.arrayGrade = self.selectedGrade
            
            let destVC = JobInformationViewController()
            destVC.jobDetailVC = self.jobDetailVC
            self.navigationController?.pushViewController(destVC, animated: true)
        }
    }
    
}
extension TeachingGradeViewController{
    private func setMainInterface() {
        progressView1.setRoundView()
        progressView2.setRoundView()
        progressView3.setRoundView()
        progressView4.setRoundView()
        applyButton.loginRound()
    }
    
    private func checkData() {
        if selectedGrade.count == 0{
            self.applyButton.isEnabled = false
            self.applyButton.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        }else{
            self.applyButton.isEnabled = true
            self.applyButton.backgroundColor = #colorLiteral(red: 0, green: 0.399238348, blue: 0.6880209446, alpha: 1)
        }
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
        cell.setInterface()
        cell.lokasiLabel.text = ConstantManager.grade[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            let data = ConstantManager.grade[indexPath.row]
            selectedGrade.insert(data, at: 0)
            checkData()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        let data = ConstantManager.grade[indexPath.row]
        if let index = selectedGrade.firstIndex(of: data) {
            selectedGrade.remove(at: index)
            checkData()
        }
    }
    
}
