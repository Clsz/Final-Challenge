//
//  SubjectCollectionViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 16/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelSubjek: UILabel!
    
    func setView(subject:String){
        self.labelSubjek.text = subject
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
