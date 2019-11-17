//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: BaseViewController {
    
    let bimbel = [
        "Next Level Bimbel",
        "Smart Mandarin Bimbel",
        "B Smart Bimbel",
        "Bimbel Salembra Group(SG)",
        "Yayasan Pendidikan Avicenna Prestasi",
        "Aldy bimbel"
    ]
    
    let bimbelLokasi = [
        "Kota Tangerang Selatan",
        "Kota Tangerang",
        "Jakarta Barat",
        "Kota Tangerang Selatan",
        "Jakarta Selatan",
         "Jakarta Selatan"
    ]
    
    let gajiBimbel = [
        "2.000.000 - 3.000.0000",
        "2.500.000 - 3.500.0000",
        "1.800.000 - 3.000.0000",
        "1.500.000 - 2.500.0000",
        "4.000.000 - 5.000.0000",
        "4.000.000 - 5.000.0000"
    ]
    
    let images = UIImage(named: "school")
    
    @IBOutlet weak var jobTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Pekerjaan")
    }
    
    
    @IBAction func filterTapped(_ sender: UIButton) {
        let filterVC = FilterViewController()
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    
    
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bimbel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! ListJobTableViewCell
        
        cell.bimbelView.layer.borderWidth = 3
        cell.bimbelView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.bimbelView.layer.cornerRadius = 15
        cell.bimbelView.layer.masksToBounds = true
        cell.bimbelView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectionStyle = .none
        
        cell.bimbelName.text = bimbel[indexPath.row]
        cell.bimbelLocation.text = bimbelLokasi[indexPath.row]
        cell.bimbelSubject.text = gajiBimbel[indexPath.row]
        cell.bimbelPhoto.image = images
        
        return cell
    }
    
    func cellDelegate(){
        jobTableView.dataSource = self
        jobTableView.delegate = self
    }
    
    func registerCell() {
        jobTableView.register(UINib(nibName: "ListJobTableViewCell", bundle: nil), forCellReuseIdentifier: "jobCell")
    }
    
}




