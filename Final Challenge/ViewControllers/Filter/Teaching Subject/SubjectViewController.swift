//
//  SubjectViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

protocol SubjectProtocol {
    func sendIndexs(arrIndex:[Int])
}

class SubjectViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var subjekTV: UITableView!
    
    let destVC = FilterViewController()
    
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
    
    var selected : [Int] = []
    
    var subjekDelegate:SubjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        searchCellDelegate()
        self.hideKeyboardWhenTappedAround()
        setUpSearchBar()
        subjekTV.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Kategori Pelajaran")
    }
    
    func setUpSearchBar() {
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = #colorLiteral(red: 0.9214878678, green: 0.9216204286, blue: 0.9214589, alpha: 1)
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func subjectAppliedTapped(_ sender: UIButton) {
        self.subjekDelegate?.sendIndexs(arrIndex: selected)
               self.navigationController?.popViewController(animated: true)
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
        cell.selectionStyle = .none
        
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
            selected.append(indexPath.row)
            ConstantManager.tempArraySubject.insert(subjek[indexPath.row], at: 0)
           }
       }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
          
          if let index = ConstantManager.tempArraySubject.firstIndex(of: subjek[indexPath.row]) {
              ConstantManager.tempArraySubject.remove(at: index)
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


