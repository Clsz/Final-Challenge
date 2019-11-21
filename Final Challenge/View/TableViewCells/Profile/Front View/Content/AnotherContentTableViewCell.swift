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
    @IBOutlet weak var showMoreButton: UIButton!
    var contentDelegate:ProfileProtocol?
    var customIndex:Int!
    var tutorCustom:Tutor!
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
        if customIndex == 2{
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
        
        setInterface()
    }
    
    private func setInterface() {
        self.showMoreButton.loginRound()
    }
}
extension AnotherContentTableViewCell:SendTutorToCustom{
    func sendTutor(tutor: Tutor) {
        self.tutorCustom = tutor
    }
}
extension AnotherContentTableViewCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if customIndex == 2{
            return 1
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if customIndex == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: customLanguageTableViewCell, for: indexPath) as! CustomLanguageTableViewCell
            cell.setCell(name: tutorCustom.tutorLanguage[indexPath.row].languageName, level: tutorCustom.tutorLanguage[indexPath.row].languageProficiency)
            return cell
        }else{
            let date = tutorCustom.tutorExperience[indexPath.row].startDate + " " + tutorCustom.tutorExperience[indexPath.row].endDate
            
            let cell = tableView.dequeueReusableCell(withIdentifier: customExperieneTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
            cell.setCell(name: tutorCustom.tutorExperience[indexPath.row].title, place: tutorCustom.tutorExperience[indexPath.row].location, date: date)
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
