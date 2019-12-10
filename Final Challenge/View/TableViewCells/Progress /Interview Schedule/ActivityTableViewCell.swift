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
    var activityDelegate:ActivityProtocol?
    var day:[String] = []
    var scheduleStart:[String] = []
    var scheduleEnd:[String] = []
    
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
    
    @IBAction func requestScheduleTapped(_ sender: Any) {
        activityDelegate?.requestNewSchedule()
    }
    
}
extension ActivityTableViewCell{
    func setCell(text:String, hint:String, anotherText:String, equipment:String, button:String) {
        self.label1.text = text
        self.label2.text = hint
        self.label3.text = anotherText
        self.labelEquipment.text = equipment
        self.requestScheduleButton.setTitle(button, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.viewEquipment.outerRound()
        self.requestScheduleButton.loginRound()
    }
    
}
extension ActivityTableViewCell:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dsCell", for: indexPath) as! DetailScheduleTableViewCell
//        cell.jadwalView.layer.borderWidth = 3
//        cell.jadwalView.layer.borderColor =
        cell.backgroundColor = .white
         cell.jadwalView.layer.cornerRadius = 15
         cell.jadwalView.layer.masksToBounds = true
        cell.jadwalView.backgroundColor = .white
        cell.dayLabel.textColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        cell.scheduleLabel.textColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
         
         let schedule = "\(scheduleStart[indexPath.row]) " + " - " + "\(scheduleEnd[indexPath.row]) "
         cell.setView(day: day[indexPath.row], time: schedule)
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)  as? DetailScheduleTableViewCell{
            UIView.animate(withDuration: 0.3, animations: {
                cell.dayLabel.textColor = .white
                cell.scheduleLabel.textColor = .white
                cell.jadwalView.backgroundColor = #colorLiteral(red: 0.1062052175, green: 0.4349771738, blue: 0.6650052667, alpha: 1)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DetailScheduleTableViewCell {
            UIView.animate(withDuration: 0.3, animations: {
                cell.dayLabel.textColor =  #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
                cell.scheduleLabel.textColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
                cell.jadwalView.backgroundColor = .white
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

