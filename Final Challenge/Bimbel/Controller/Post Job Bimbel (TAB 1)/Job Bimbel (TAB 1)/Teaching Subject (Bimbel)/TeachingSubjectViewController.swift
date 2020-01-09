//
//  TeachingSubjectViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 04/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TeachingSubjectViewController: BaseViewController{

    @IBOutlet weak var progressView1: UIView!
    @IBOutlet weak var progressView2: UIView!
    @IBOutlet weak var progressView3: UIView!
    @IBOutlet weak var progressView4: UIView!
    @IBOutlet weak var tableViewTS: UITableView!
    @IBOutlet weak var btnApplySubject: UIButton!
    var selectedSubject:[String] = []
    let cellJob = "locationCell"
    var flag:Bool = true
    var delegate:passDataToDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Subject")
        setMainInterface()
        checkData()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func applySubjectTapped(_ sender: UIButton) {
        if flag == false{
            delegate?.passDataSubject(dataSubject: selectedSubject)
            self.navigationController?.popViewController(animated: true)
        }else{
            let lastVC = JobDetailsViewController()
            lastVC.arraySubject = self.selectedSubject
            
            let destVC = TeachingGradeViewController()
            destVC.jobDetailVC = lastVC
            
            self.navigationController?.pushViewController(destVC, animated: true)
        }
    }
    
}
extension TeachingSubjectViewController{
    private func setMainInterface() {
        progressView1.setRoundView()
        progressView2.setRoundView()
        progressView3.setRoundView()
        progressView4.setRoundView()
        btnApplySubject.loginRound()
    }
    
    private func checkData() {
        if selectedSubject.count == 0{
            self.btnApplySubject.isEnabled = false
            self.btnApplySubject.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        }else{
            self.btnApplySubject.isEnabled = true
            self.btnApplySubject.backgroundColor = #colorLiteral(red: 0, green: 0.399238348, blue: 0.6880209446, alpha: 1)
        }
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
        cell.setInterface()
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
            checkData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        let data:(key:Int, value:String) = ConstantManager.allSubject[indexPath.row]
        if let index = selectedSubject.firstIndex(of: data.value) {
            selectedSubject.remove(at: index)
            checkData()
        }
    }
    
}


