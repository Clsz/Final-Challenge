//
//  ApplyButtonTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

protocol DetailProfileDelegate{
    func addDetail(tutor:Tutor)
}

class ApplyButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    var delegate:DetailProfileDelegate?
    var tutor:Tutor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.loginRound()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        delegate?.addDetail(tutor: tutor)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
