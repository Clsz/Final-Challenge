//
//  LocationViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 13/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class LocationViewController: BaseViewController {
    
    @IBOutlet weak var locationTV: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let destVC = FilterViewController()
    
    let lokasi = [
        "Kab. Lebak",
        "Kab. Pandeglang",
        "Kab. Tangerang",
        "Kota Cilegon",
        "Kota Serang",
        "Kota Tangerang Selatan",
        "Kepulauan Seribu",
        "Jakarta Utara",
        "Jakarta Timur",
        "Jakarta Selatan"
    ]
    
    var selected : [Int] = []
    
    var searchLocation = [String]()
    var searching = false
    
    var aldiDelegate:sendLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        searchCellDelegate()
        self.hideKeyboardWhenTappedAround()
        setUpSearchBar()
        locationTV.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Locations")
    }
    
    func setUpSearchBar() {
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8980392157, alpha: 1)
    }
    
    @IBAction func lokasiAplliedTapped(_ sender: UIButton) {
        self.aldiDelegate?.sendIndex(arrIndex: selected)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension LocationViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchLocation.count
        } else{
            return lokasi.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        
        cell.selectionStyle = .none
        
        if searching  {
            cell.lokasiLabel.text = searchLocation[indexPath.row]
        } else {
            cell.lokasiLabel.text = lokasi[indexPath.row]
        }
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            selected.append(indexPath.row)
            ConstantManager.tempArray.insert(lokasi[indexPath.row], at: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
        if let index = ConstantManager.tempArray.firstIndex(of: lokasi[indexPath.row]) {
            ConstantManager.tempArray.remove(at: index)
        }
    }
    
    func cellDelegate(){
        locationTV.dataSource = self
        locationTV.delegate = self
    }
    
    func registerCell() {
        locationTV.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "locationCell")
    }
    
}
extension LocationViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLocation = lokasi.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        locationTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        locationTV.reloadData()
    }
    
    func searchCellDelegate(){
        searchBar.delegate = self
    }
    
}
