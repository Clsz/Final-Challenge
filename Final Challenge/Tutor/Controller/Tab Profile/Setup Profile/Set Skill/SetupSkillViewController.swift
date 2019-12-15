//
//  SetupSkillViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 10/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupSkillViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let setupSkillTableViewCellID = "SetupSkillTableViewCellID"
    let choosenSkillTableViewCellID = "ChoosenSkillTableViewCellID"
    let submitCell = "submitCell"
    var selectedChoosenSkills:[(key:Int, value:String)] = [(key:Int,value:String)]()
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Skills")
        
    }
    
}
extension SetupSkillViewController:SendFlag{
    func sendFlag(flag: Bool) {
        self.flag = flag
        self.tableView.reloadData()
    }
    
}
//extension SetupSkillViewController:ChooseSkillProtocol{
//    func passData(dataSkills: [(key: Int, value: String)]) {
//        self.selectedChoosenSkills = dataSkills
//    }
//    
//    func reloadCV(collectionView: UICollectionView) {
//        collectionView.reloadData()
//    }
//}
extension SetupSkillViewController : refreshTableProtocol{
    func refreshTableView() {
        self.tableView.reloadData()
    }
}
extension SetupSkillViewController: UITableViewDelegate, UITableViewDataSource{
    func registerCell() {
        tableView.register(UINib(nibName: "SetupSkillTableViewCell", bundle: nil), forCellReuseIdentifier: setupSkillTableViewCellID)
        tableView.register(UINib(nibName: "ChoosenSkillTableViewCell", bundle: nil), forCellReuseIdentifier: choosenSkillTableViewCellID)
        tableView.register(UINib(nibName: "SubmitTableViewCell", bundle: nil), forCellReuseIdentifier: submitCell)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == false{
            return 2
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if flag == true{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: setupSkillTableViewCellID, for: indexPath) as! SetupSkillTableViewCell
                
                return cell
            } else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: choosenSkillTableViewCellID, for: indexPath) as! ChoosenSkillTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
                
                return cell
            }
        }else {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: setupSkillTableViewCellID, for: indexPath) as! SetupSkillTableViewCell
                cell.sendFlagDelegate = self
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as! SubmitTableViewCell
                
                return cell
            }
        }
        
    }
    
    
}
