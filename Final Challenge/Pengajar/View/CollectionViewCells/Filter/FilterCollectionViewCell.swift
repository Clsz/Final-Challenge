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
                self.kotakFilter.backgroundColor = self.isSelected ? #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.imageFilter.image = self.isSelected ? self.images:self.images1
                self.labelFilter.textColor = self.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
}
extension FilterCollectionViewCell{
    func setView() {
        kotakFilter.layer.cornerRadius = 10
        kotakFilter.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        kotakFilter.layer.borderWidth = 1
    }
}

