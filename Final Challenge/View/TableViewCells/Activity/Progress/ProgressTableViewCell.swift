//
//  ProgressTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    @IBOutlet weak var namaBimbel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusBimbel: UILabel!
    @IBOutlet weak var viewBimbel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ProgressTableViewCell{
    func setCell(nama:String, status:String) {
        self.namaBimbel.text = nama
        self.statusBimbel.text = status
        
        setInterface()
    }
    
    private func setInterface() {
        self.viewBimbel.dropShadow()
        self.viewBimbel.outerRound2()
        self.viewBimbel.setBorder()
        self.viewBimbel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
