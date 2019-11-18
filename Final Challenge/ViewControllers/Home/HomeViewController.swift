//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: BaseViewController{
    
    
    
    let images = UIImage(named: "school")
    var datas = [Courses]()
    var course:Courses!
    
    
    @IBOutlet weak var jobTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        set()
        jobTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Pekerjaan")
    }
    
    
    @IBAction func filterTapped(_ sender: UIButton) {
        let filterVC = FilterViewController()
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
}

extension HomeViewController{
    
    func set() {
        datas.append(bimbel1)
        datas.append(bimbel2)
        datas.append(bimbel3)
        datas.append(bimbel4)
        datas.append(bimbel5)
        datas.append(bimbel6)
        datas.append(bimbel7)
        datas.append(bimbel8)
        datas.append(bimbel9)
        datas.append(bimbel10)
    }
    
}

extension HomeViewController:HomeProtocol{
    func bimbelTapped() {
        let destVC = DetailBimbelViewController()
        destVC.course = self.course
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
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
        cell.bimbelPhoto.image = images
        
        let data = datas[indexPath.row]
        
        if let namaBimbel = data.courseName {
            cell.bimbelName.text = namaBimbel
        }
        
        if let lokasiBimbel = data.courseLocation{
            cell.bimbelLocation.text = lokasiBimbel
        }
        
        let gajiBimbel =  "Rp \(String(describing: data.courseMinFare!)) - Rp \(String(describing: data.courseMaxFare!))"
        cell.bimbelSubject.text = gajiBimbel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bimbelTapped()
    }
    
    func cellDelegate(){
        jobTableView.dataSource = self
        jobTableView.delegate = self
    }
    
    func registerCell() {
        jobTableView.register(UINib(nibName: "ListJobTableViewCell", bundle: nil), forCellReuseIdentifier: "jobCell")
    }
    
}




