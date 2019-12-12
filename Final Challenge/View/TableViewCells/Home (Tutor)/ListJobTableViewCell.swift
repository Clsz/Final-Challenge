//
//  ListJobTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ListJobTableViewCell: UITableViewCell {

    @IBOutlet weak var bimbelName: UILabel!
    @IBOutlet weak var bimbelLocation: UILabel!
    @IBOutlet weak var bimbelSubject: UILabel!
    @IBOutlet weak var bimbelView: UIView!
    
    var course:Courses!
    
    func setView(name:String, location:String, subject:String) {
        bimbelName.text = name
        bimbelLocation.text = location
        bimbelSubject.text = subject
        
        setInterface()
    }
    
    private func setInterface () {
        bimbelView.layer.borderWidth = 3
        bimbelView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bimbelView.layer.cornerRadius = 15
        bimbelView.layer.masksToBounds = true
        bimbelView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        selectionStyle = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
