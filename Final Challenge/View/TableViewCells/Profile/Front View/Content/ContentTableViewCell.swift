//
//  ContentTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
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
    
    @IBAction func editTapped(_ sender: Any) {
        contentDelegate?.skillTapped()
    }
    
}
extension ContentTableViewCell{
    func setCell(title:String,button:String) {
        self.titleLabel.text = title
        self.editButton.setTitle(button, for: .normal)
    }
    
    private func setInterface() {
        self.collectionView.outerRound()
    }
}
