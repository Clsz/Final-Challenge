//
//  SubmitTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SubmitTableViewCell: UITableViewCell {

    @IBOutlet weak var requestButton: UIButton!
    var contentDelegate:DetailBimbel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func requestTapped(_ sender: UIButton) {
        contentDelegate?.requestTapped()
    }
    
}
extension SubmitTableViewCell{
    func setCell(button:String) {
        self.requestButton.setTitle(button, for: .normal)
        setInterface()
    }
    
    private func setInterface(){
        self.requestButton.loginRound()
    }
}
