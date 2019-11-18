//
//  AdditionalExperienceViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AdditionalExperienceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAdditional: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    let additional = "HintWithTableTableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Experience Setup")
    }
    
    @IBAction func addAddtionalTapped(_ sender: Any) {
    }
    
    @IBAction func applyTapped(_ sender: Any) {
    }
    
}
extension AdditionalExperienceViewController{
    private func setMainInterface() {
        self.addAdditional.loginRound()
        self.applyButton.loginRound()
    }
}
extension AdditionalExperienceViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "HintWithTableTableViewCell", bundle: nil), forCellReuseIdentifier: additional)
    }
    
    func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: additional, for: indexPath) as! HintWithTableTableViewCell
        cell.setCell(text: "PLEASE ADD YOUR EXPERIENCE INFORMATION")
        return cell
    }
    
}
