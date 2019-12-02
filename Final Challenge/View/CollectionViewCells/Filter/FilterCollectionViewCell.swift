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
    var tempSelectedLocation:[String] = []
    var tempSelectedGrade:[String] = []
    var tempSelectedSubject:[String] = []
    let images = UIImage(named: "tick")
    let images1 = UIImage(named: "Add")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            DispatchQueue.main.async {
                self.kotakFilter.layer.borderWidth = self.isSelected ? 0 : 1
                self.kotakFilter.backgroundColor = self.isSelected ? #colorLiteral(red: 0.3254901961, green: 0.7803921569, blue: 0.9411764706, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.imageFilter.image = self.isSelected ? self.images:self.images1
            }
        }
    }
    
}
extension FilterCollectionViewCell{
    func setView() {
        kotakFilter.layer.cornerRadius = 10
        kotakFilter.layer.borderColor = #colorLiteral(red: 0.2392156863, green: 0.431372549, blue: 0.8, alpha: 1)
        kotakFilter.layer.borderWidth = 1
    }
}

