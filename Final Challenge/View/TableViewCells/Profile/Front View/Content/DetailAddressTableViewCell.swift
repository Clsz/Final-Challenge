//
//  DetailAddressTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class DetailAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    var bimbelDelegate:BimbelProtocol?
    var index:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editTapped(_ sender: Any) {
        bimbelDelegate?.addressTapped()
    }
    
}
extension DetailAddressTableViewCell{
    func setCell(_ label:String, _ button:String) {
        self.label.text = label
        self.button.setTitle(button, for: .normal)
        self.textView.setBorderBlue()
        self.textView.outerRound()
    }
}
