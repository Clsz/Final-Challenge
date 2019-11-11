//
//  AnotherContentTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class AnotherContentTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate:DetailProfileDelegate?
    var tutor:Tutor!
    
    func setView(text:String) {
        label.text = text
    }
    
    @IBAction func addTapped(_ sender: Any) {
        delegate?.addDetail(tutor: tutor)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
