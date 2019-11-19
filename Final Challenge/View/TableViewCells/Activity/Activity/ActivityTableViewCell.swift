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
    @IBOutlet weak var requestScheduleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var additionTF: UITextField!
    var interviewSchedule:[String] = []
    var interviewTime:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ActivityTableViewCell{
    func setCell(text:String, hint:String, anotherText:String, button:String) {
        self.label1.text = text
        self.label2.text = hint
        self.label3.text = anotherText
        self.requestScheduleButton.setTitle(button, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.additionTF.outerRound()
        self.additionTF.setLeftPaddingPoints(10.0)
        self.additionTF.contentVerticalAlignment = .top
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
    
    private func cellDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "DetailScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "dsCell")
    }
    
    
}

