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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Skills")
    }




}

extension SetupSkillViewController: UITableViewDelegate, UITableViewDataSource{
    func registerCell() {
        tableView.register(UINib(nibName: "SetupSkillTableViewCell", bundle: nil), forCellReuseIdentifier: setupSkillTableViewCellID)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: setupSkillTableViewCellID, for: indexPath) as! SetupSkillTableViewCell
        
        return cell
    }
    
    
}
