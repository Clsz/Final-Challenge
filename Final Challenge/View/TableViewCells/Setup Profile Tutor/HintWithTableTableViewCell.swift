//
//  HintWithTableTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class HintWithTableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    let CustomExperienceTableViewCell = "CustomExperienceTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        cellDelegate()
//        registerCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
extension HintWithTableTableViewCell{
    func setCell(text:String) {
        self.label.text = text
    }
}

//extension HintWithTableTableViewCell: UITableViewDelegate, UITableViewDataSource {
//    func registerCell() {
//        tableView.register(UINib(nibName: "CustomExperienceTableViewCell", bundle: nil), forCellReuseIdentifier: CustomExperienceTableViewCell)
//    }
//    
//    func cellDelegate() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        dataArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CustomExperienceTableViewCell, for: indexPath) as! CustomExperienceTableViewCell
//        cell.setCell(name: "", place: "", date: "")
//        return cell
//    }
//    
//    
//    
//    
//}
