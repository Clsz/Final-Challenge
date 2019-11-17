//
//  FilterCollectionViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var kotakFilter: UIView!
    @IBOutlet weak var imageFilter: UIImageView!
    @IBOutlet weak var labelFilter: UILabel!
    let images = UIImage(named: "tick")
    let images1 = UIImage(named: "Add")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            kotakFilter.layer.borderWidth = isSelected ? 0 : 1
            kotakFilter.backgroundColor = isSelected ? #colorLiteral(red: 0.3254901961, green: 0.7803921569, blue: 0.9411764706, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imageFilter.image = isSelected ? images:images1
        }
    }
    
}
