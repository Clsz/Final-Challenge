//
//  SkillCollectionViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SkillCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelSkill: UILabel!
    @IBOutlet weak var gambarSkill: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }

}

extension SkillCollectionViewCell{
    func setView() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        self.layer.borderWidth = 1
    }
}
