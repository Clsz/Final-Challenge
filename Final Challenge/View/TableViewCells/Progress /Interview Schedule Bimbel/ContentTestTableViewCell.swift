//
//  ContentTestTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ContentTestTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    var title:[String]?
    var date:[String]?
    var time:[String]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//extension ContentTableViewCell:UITableViewDataSource,UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//}
