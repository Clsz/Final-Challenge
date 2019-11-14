//
//  ExperienceViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ExperienceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Education")
        setupData()
        registerCell()
        cellDelegate()
    }
    
    func setupData() {
        dataArray.append(("School","Enter your School Name",0))
        dataArray.append(("Education Type","High School",1))
        dataArray.append(("Field of Study","Enter your Field of Study",0))
        dataArray.append(("Grade","Enter your Grade",0))
    }
    
}
extension ExperienceViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "DetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailProfileTableViewCell")
        tableView.register(UINib(nibName: "AnotherDetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "AnotherDetailProfileTableViewCell")
        tableView.register(UINib(nibName: "ProfileFooterViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProfileFooterViewCell")
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileFooterViewCell") as! ProfileFooterViewCell
        footerView.setView(text: "Apply Language")
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 3 ?  300 : 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let keyValue = dataArray[indexPath.row] as? (key:String,value:String,code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailProfileTableViewCell", for: indexPath) as! DetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherDetailProfileTableViewCell", for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
