//
//  AnotherDetailProfileTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 10/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AnotherDetailProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    var languageDelegate:LanguageProtocol?
    var educationDelegate:EducationProtocol?
    var experienceDelegate:ExperienceProtocol?
    var dropID:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func dropDownTapped(_ sender: Any) {
        if dropID == 0{
            languageDelegate?.dropLanguage()
        }else if dropID == 1{
            educationDelegate?.dropEducation()
        }else{
            experienceDelegate?.dropExperience()
        }
    }
    
}
extension AnotherDetailProfileTableViewCell{
    func setCell(text:String, content:String) {
        self.label.text = text
        self.textField.placeholder = content
        
        setInterface()
    }
    
    private func setInterface() {
        self.button.loginRound()
        self.textField.outerRound()
        self.textField.setLeftPaddingPoints(10.0)
        
    }
    
}
