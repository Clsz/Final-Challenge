//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class HomeViewController: BaseViewController{
    
    let images = UIImage(named: "school")
    var listJob = [CKRecord]()
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var homeDelegate:HomeProtocol?
    
    
    @IBOutlet weak var jobTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryJob()
        cellDelegate()
        registerCell()
        jobTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Jobs")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func filterTapped(_ sender: UIButton) {
        let filterVC = FilterViewController()
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
}

extension HomeViewController{
    private func queryJob() {
        let query = CKQuery(recordType: "Job", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.listJob = sortedRecords
            DispatchQueue.main.async {
                self.jobTableView.reloadData()
            }
        }
    }

}
extension HomeViewController:HomeProtocol{
    func bimbelTapped() {
        
    }
    
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJob.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! ListJobTableViewCell
        cell.bimbelView.layer.borderWidth = 3
        cell.bimbelView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.bimbelView.layer.cornerRadius = 15
        cell.bimbelView.layer.masksToBounds = true
        cell.bimbelView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
        cell.selectionStyle = .none
        cell.bimbelPhoto.image = images
    
        let data = listJob[indexPath.row]
        
        cell.bimbelName.text = (data.value(forKey: "courseName") as! String)
        cell.bimbelLocation.text = (data.value(forKey: "courseAddress") as! String)
        let minFare = (data.value(forKey: "minimumSalary") as! Double)
        let maxFare = (data.value(forKey: "maximumSalary") as! Double)
        let gajiBimbel =  "Rp \(String(describing: minFare.formattedWithSeparator)) - Rp \(String(describing: maxFare.formattedWithSeparator))"
        cell.bimbelSubject.text = gajiBimbel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailBimbelViewController()
        destVC.job = listJob[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func cellDelegate(){
        jobTableView.dataSource = self
        jobTableView.delegate = self
    }
    
    func registerCell() {
        jobTableView.register(UINib(nibName: "ListJobTableViewCell", bundle: nil), forCellReuseIdentifier: "jobCell")
    }
    
}

