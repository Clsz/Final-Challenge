//
//  AdditionalEducationViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AdditionalEducationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAdditional: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    let hint = "HintTableViewCellID"
    let CustomExperienceTableViewCell = "CustomExperienceTableViewCellID"
    var dataSchoolName:[String] = []
    var dataGrade:[String] = []
    var dataFieldStudy:[String] = []
    var dataStart:[Int] = []
    var dataEnd:[Int] = []
    var dataGpa:[Double] = []
    var tutor:Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Education")
    }
    
    @IBAction func addAddtionalTapped(_ sender: Any) {
    }
    
    @IBAction func applyTapped(_ sender: Any) {
    }
    
}
extension AdditionalEducationViewController{
    private func setMainInterface() {
        self.addAdditional.loginRound()
        self.applyButton.loginRound()
    }
}
extension AdditionalEducationViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        //        tableView.register(UINib(nibName: "HintTableViewCell", bundle: nil), forCellReuseIdentifier: hint)
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: CustomExperienceTableViewCell)
    }
    
    func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSchoolName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
        let fos = "Field of Study: \(dataFieldStudy)"
        cell.setCell(name: String(dataSchoolName.count), place: String(dataGrade.count), date: fos)
        return cell}
}

