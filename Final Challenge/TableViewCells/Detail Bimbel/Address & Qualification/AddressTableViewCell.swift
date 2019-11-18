//
//  AddressTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    var homeDelegate:HomeProtocol?
    var course:Courses!
    
    func setView(title:String, description:String) {
        self.addressTitle.text = title
        self.addressLabel.text = description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
