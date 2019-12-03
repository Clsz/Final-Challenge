//
//  ContentViewTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ContentViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var tutorDelegate:ProfileProtocol?
    var bimbelDelegate:BimbelProtocol?
    var index:Int?
    let customExperieneTableViewCell = "CustomExperienceTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()
        cellDelegate()
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if index == 0{
            tutorDelegate?.educationTapped()
        }else{
            bimbelDelegate?.gradesTapped()
        }
    }
    
}
extension ContentViewTableViewCell{
    func setCell(text:String, button:String) {
        self.label.text = text
        self.button.setTitle(button, for: .normal)
    }
}
extension ContentViewTableViewCell:SendTutorToCustom{
    func sendTutor(tutor: Tutor) {
        
    }
}
extension ContentViewTableViewCell:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customExperieneTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
        
        return cell
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "CustomExperienceTableViewCell" , bundle: nil), forCellReuseIdentifier: customExperieneTableViewCell)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
