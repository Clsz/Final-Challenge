//
//  SubjectViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

protocol SubjectProtocol {
    func kirimIndex(arrayIndex:[Int])
}

class SubjectViewController: BaseViewController {
    
    @IBOutlet weak var searchSubjectBar: UISearchBar!
    @IBOutlet weak var subjekTV: UITableView!
    let destVC = FilterViewController()
    var subjekDelegate:SubjectProtocol?
    var searchSubjek = [String]()
    var selected : [Int] = []
    var searching = false
    let images = UIImage(named: "Oval")
    let subjek = ["Bahasa Mandarin", "Bahasa Indonesia", "Sosiologi", "Ekonomi", "Sejarah", "Kesenian", "Code"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        cariCellDelegate()
        self.hideKeyboardWhenTappedAround()
        setUpSearchBar()
        subjekTV.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Teaching Subjects")
    }
    
    @IBAction func subjectAppliedTapped(_ sender: UIButton) {
        self.subjekDelegate?.kirimIndex(arrayIndex: selected)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SubjectViewController{
    func setUpSearchBar() {
        searchSubjectBar.layer.borderWidth = 1
        searchSubjectBar.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchSubjectBar.searchTextField.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8980392157, alpha: 1)
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
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            selected.append(indexPath.row)
            ConstantManager.subject.insert(subjek[indexPath.row], at: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
        if let index = ConstantManager.subject.firstIndex(of: subjek[indexPath.row]) {
            ConstantManager.subject.remove(at: index)
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
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchBar.setShowsCancelButton(true, animated: true)
           searchBar.showsCancelButton = true
       }
       
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchBar.setShowsCancelButton(false, animated: false)
           searchBar.showsCancelButton = false
       }
    
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
    
    func cariCellDelegate(){
        searchSubjectBar.delegate = self
    }
    
}
