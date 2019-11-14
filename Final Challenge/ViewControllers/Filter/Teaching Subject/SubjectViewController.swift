//
//  SubjectViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SubjectViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var subjekTV: UITableView!
    
    let subjek = [
        "Matematika",
        "Fisika",
        "Kimia",
        "Bahasa Inggris",
        "Bahasa Mandarin",
        "Bahasa Indonesia",
        "Sosiologi",
        "Ekonomi",
        "Sejarah",
        "Kesenian",
        "Code",
    ]
    
    let images = UIImage(named: "Oval")
    
    var searchSubjek = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        searchCellDelegate()
        self.hideKeyboardWhenTappedAround()
        setUpSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Kategori Pelajaran")
    }
    
    func setUpSearchBar() {
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = #colorLiteral(red: 0.9214878678, green: 0.9216204286, blue: 0.9214589, alpha: 1)
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    
}

extension SubjectViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchSubjek.count
        } else{
            return subjek.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjekCell", for: indexPath) as! SubjectTableViewCell
        
        cell.gambarSubjek.image = images
        
        if searching  {
            cell.namaSubjek.text = searchSubjek[indexPath.row]
        } else {
            cell.namaSubjek.text = subjek[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
           {
               tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
           }
           else
           {
               tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
           }
       }
    
    func cellDelegate(){
        subjekTV.dataSource = self
        subjekTV.delegate = self
    }
    
    func registerCell() {
        subjekTV.register(UINib(nibName: "SubjectTableViewCell", bundle: nil), forCellReuseIdentifier: "subjekCell")
    }
    
}

extension SubjectViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSubjek = subjek.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        subjekTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        subjekTV.reloadData()
    }
    
    func searchCellDelegate(){
        searchBar.delegate = self
    }
    
}


