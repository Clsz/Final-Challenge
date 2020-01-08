//
//  TitleBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 08/01/20.
//  Copyright © 2020 12. All rights reserved.
//

import UIKit

class TitleBimbelTableViewCell: UITableViewCell {
    @IBOutlet weak var imageProfileBimbel: UIImageView!
    @IBOutlet weak var labelNameBimbel: UILabel!
    @IBOutlet weak var labelHourBimbel: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TitleBimbelTableViewCell{
    func setCellBimbel(image:UIImage, name:String, hour:String) {
        self.labelNameBimbel.text = name
        self.labelHourBimbel.text = hour
        setInterface()
        
    }
    
    private func setInterface() {
        self.outerView.outerRound()
        self.imageProfileBimbel.setRounded()
    }
    
}
