//
//  LanguageViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 10/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:[Any?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Language"
    }
    
    func setupData() {
        dataArray.append(("Language","Enter your Language",0))
        dataArray.append(("Language Proficiency","Beginner",1))
    }

}

extension LanguageViewController:UITableViewDataSource,UITableViewDelegate{
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
        return indexPath.row == 0 ? 115 : 550
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
