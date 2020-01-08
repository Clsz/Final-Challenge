//
//  ContentTestTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 15/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ContentTestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var date:[String] = []
    var time:[String] = []
    
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
extension ContentTestTableViewCell:UITableViewDataSource,UITableViewDelegate{
    
    private func registerCell() {
        tableView.register(UINib(nibName: "InterviewTestTableViewCell", bundle: nil), forCellReuseIdentifier: "InterviewTestTableViewCellID")
    }
    
    private func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterviewTestTableViewCellID", for: indexPath) as! InterviewTestTableViewCell
        cell.setCell(index: indexPath.row, day: date[indexPath.row] , time: time[indexPath.row])
        return cell
    }
}
