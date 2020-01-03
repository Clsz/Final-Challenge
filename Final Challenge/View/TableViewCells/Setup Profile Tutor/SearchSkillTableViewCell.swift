//
//  SearchSkillTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 27/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SearchSkillTableViewCell: UITableViewCell {
    @IBOutlet weak var labelSearch: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInterface()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension SearchSkillTableViewCell{
    func setInterface() {
        self.outerView.setBorderBlue()
        self.outerView.outerRound()
    }
}
