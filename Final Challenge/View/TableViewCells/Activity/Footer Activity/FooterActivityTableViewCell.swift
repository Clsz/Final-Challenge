//
//  FooterActivityTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 18/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FooterActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    var footerDelegate:ActivityProcess?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func acceptTapped(_ sender: Any) {
        footerDelegate?.accept()
    }
    
    @IBAction func rejectTapped(_ sender: Any) {
        footerDelegate?.reject()
    }
}
extension FooterActivityTableViewCell{
    func setCell(accept:String, reject:String) {
        self.acceptButton.setTitle(accept, for: .normal)
        self.rejectButton.setTitle(reject, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.acceptButton.loginRound()
        self.rejectButton.loginRound()
    }
}
