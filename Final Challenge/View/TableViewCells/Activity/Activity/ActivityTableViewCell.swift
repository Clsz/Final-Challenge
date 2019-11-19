//
//  ActivityTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 18/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var labelEquipment: UILabel!
    
    @IBOutlet weak var requestScheduleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewEquipment: UIView!
    
    var interviewSchedule:[String] = []
    var interviewTime:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ActivityTableViewCell{
    func setCell(text:String, hint:String, anotherText:String, equipment:String, button:String) {
        self.label1.text = text
        self.label2.text = hint
        self.label3.text = anotherText
        self.labelEquipment.text = equipment
        self.requestScheduleButton.setTitle(button, for: .normal)
         self.viewEquipment.outerRound()
    }
}
extension ActivityTableViewCell:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interviewSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dsCell", for: indexPath) as! DetailScheduleTableViewCell
        cell.setView(day: interviewSchedule[indexPath.row], time: interviewTime[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               if let cell = tableView.cellForRow(at: indexPath) {
                   UIView.animate(withDuration: 0.3, animations: {
                       cell.contentView.backgroundColor = #colorLiteral(red: 0.3812787533, green: 0.8201360106, blue: 0.9539147019, alpha: 1)
                   })
        } else if let cell = tableView.cellForRow(at: indexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    })
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
    }
    }
    
    
    private func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "DetailScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "dsCell")
    }
    
    
}

