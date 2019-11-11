//
//  AchievementTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate:DetailProfileDelegate?
    var tutor:Tutor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addTapped(_ sender: Any) {
        delegate?.addDetail(tutor: tutor)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
