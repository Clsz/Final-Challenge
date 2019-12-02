//
//  AchievementTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var contentDelegate:ProfileProtocol?
    var tutor:Tutor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addTapped(_ sender: Any) {
        contentDelegate?.achievementTapped()
    }
    
}
extension AchievementTableViewCell{
    func setCell(label:String, button:String) {
        self.collectionView.outerRound()
        self.label.text = label
        self.button.setTitle(button, for: .normal)
    }
    
}
