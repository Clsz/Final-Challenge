//
//  LocationTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var lokasiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
extension LocationTableViewCell{
    func setInterface() {
        self.outerRound3()
        self.setBorder()
    }
}
