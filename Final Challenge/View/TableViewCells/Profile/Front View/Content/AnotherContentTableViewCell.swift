//
//  AnotherContentTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AnotherContentTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var contentDelegate:ProfileProtocol?
    var index:Int!
    var title:[String]?
    var content:[String]?
    var footer:[String]?
    //Only for Experience
    var startYear:[String]?
    var endYear:[String]?
    
    let customLanguageTableViewCell = "CustomLanguageTableViewCellID"
    let customExperieneTableViewCell = "CustomExperienceTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if index == 2{
            contentDelegate?.languageTapped()
        }else{
            contentDelegate?.experienceTapped()
        }
    }
    
}
extension AnotherContentTableViewCell{
    func setCell(text:String, button:String) {
        self.label.text = text
        self.button.setTitle(button, for: .normal)
        
    }
}
extension AnotherContentTableViewCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: customExperieneTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
            cell.setCell(name: title?[indexPath.row] ?? "", place: content?[indexPath.row] ?? "", date: footer?[indexPath.row] ?? "")
            self.tableView.separatorColor = .white
            self.tableView.separatorInset = UIEdgeInsets.init(top: 0.0, left: 15.0, bottom: 0.0, right: 0.0)
            return cell
        }else if index == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: customLanguageTableViewCell, for: indexPath) as! CustomLanguageTableViewCell
            cell.outerView.setBorder()
            cell.outerView.outerRound()
            cell.setCell(name: title?[indexPath.row] ?? "", level: content?[indexPath.row] ?? "")
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: customExperieneTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
            let start = startYear?[indexPath.row] ?? ""
            let end = endYear?[indexPath.row] ?? ""
            cell.outerView.setBorder()
            cell.outerView.outerRound()
            cell.setCell(name: title?[indexPath.row] ?? "", place: content?[indexPath.row] ?? "", date: start + " - " + end)
            return cell
        }
        
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "CustomLanguageTableViewCell", bundle: nil), forCellReuseIdentifier: customLanguageTableViewCell)
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: customExperieneTableViewCell)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
