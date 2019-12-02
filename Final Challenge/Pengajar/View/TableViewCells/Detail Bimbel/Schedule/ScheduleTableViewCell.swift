//
//  ScheduleTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var scheduleTitle: UILabel!
    @IBOutlet weak var scheduleTV: UITableView!
    var day:[String] = []
    var scheduleStart:[String] = []
    var scheduleEnd:[String] = []
    var refreshProtocol:refreshTableProtocol?
    
    func setView(title:String) {
        self.scheduleTitle.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        refreshProtocol?.refreshTableView()
        scheduleTV.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ScheduleTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dsCell", for: indexPath) as! DetailScheduleTableViewCell
       cell.jadwalView.layer.borderWidth = 3
        cell.jadwalView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.jadwalView.layer.cornerRadius = 15
        cell.jadwalView.layer.masksToBounds = true
        cell.jadwalView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        
        let schedule = "\(scheduleStart[indexPath.row]) AM" + " - " + "\(scheduleEnd[indexPath.row]) PM"
        cell.setView(day: day[indexPath.row], time: schedule)
        return cell
    }
    
    private func cellDelegate() {
        scheduleTV.dataSource = self
        scheduleTV.delegate = self
    }
    
    private func registerCell() {
        scheduleTV.register(UINib(nibName: "DetailScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "dsCell")
    }
    
    
}
