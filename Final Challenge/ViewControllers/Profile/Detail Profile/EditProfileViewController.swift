//
//  EditProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let detailProfile = "DetailHeaderTableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        setupView(text: "Personal")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Personal")
    }

}

extension EditProfileViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProfile, for: indexPath) as! DetailHeaderTableViewCell
        cell.setView()
        return cell
    }
    
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "DetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: detailProfile)
    }
    
    
}
