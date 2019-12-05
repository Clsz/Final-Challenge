////
////  TeachingSubjectViewController.swift
////  Final Challenge
////
////  Created by Jason Valencius Wijaya on 04/12/19.
////  Copyright © 2019 12. All rights reserved.
////
//
//import UIKit
//
//class TeachingSubjectViewController: BaseViewController {
//
//    
//    @IBOutlet weak var tableViewCuy: UITableView!
//    
//    var tableTestingData = ["Data Satu", "Data Dua", "Data Tiga"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableViewCuy.delegate = self
//        tableViewCuy.dataSource = self
//
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.orange
//        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//        
//        let footerView = UIView()
//        footerView.backgroundColor = UIColor.blue
//        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: 50)
//
//        
//        tableViewCuy.tableHeaderView = headerView
//        tableViewCuy.tableFooterView = footerView
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        setupView(text: "Teaching Subject")
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    }
//
//
//   
//}
//
//extension TeachingSubjectViewController: UITableViewDataSource, UITableViewDelegate{
//    
//    private func registerCell() {
//        self.tableViewCuy.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: <#T##String#>)
//    }
//    
//   
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableTestingData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableViewCuy.dequeueReusableCell(withIdentifier: , for: indexPath) as! JobBimbelTableViewCell
//    }
//    
//}
