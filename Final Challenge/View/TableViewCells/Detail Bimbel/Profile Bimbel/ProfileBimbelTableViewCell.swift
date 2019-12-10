//
//  ProfileBimbelTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ProfileBimbelTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBimbel: UIView!
    @IBOutlet weak var imageBimbel: UIImageView!
    @IBOutlet weak var namaBimbel: UILabel!
    @IBOutlet weak var jamBimbel: UILabel!
    @IBOutlet weak var statusBimbel: UILabel!
    var homeDelegate:HomeProtocol?
    
    func setView(image:String, name:String, jam:String, status:String) {
        self.namaBimbel.text = name
        self.jamBimbel.text = jam
        self.statusBimbel.text = status
        self.imageBimbel.setRounded()
        self.imageBimbel.dropShadow()
        viewBimbel.outerRound()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
