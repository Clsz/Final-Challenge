//
//  SkillsViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 10/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SkillsViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var hardSkillsCV: UICollectionView!
    @IBOutlet weak var softSkillsCV: UICollectionView!
    @IBOutlet weak var applyButton: UIButton!
    let filterCell = "filterCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Skill")
        softSkillsCV.reloadData()
        hardSkillsCV.reloadData()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        let destVC = ProfileViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
extension SkillsViewController{
    private func setMainInterface() {
        hardSkillsCV.allowsMultipleSelection = true
        softSkillsCV.allowsMultipleSelection = true
        applyButton.loginRound()
    }
}
extension SkillsViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func registerCell() {
        hardSkillsCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
        softSkillsCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
    }
    
    private func cellDelegate() {
        hardSkillsCV.delegate = self
        hardSkillsCV.dataSource = self
        softSkillsCV.delegate = self
        softSkillsCV.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hardSkillsCV{
            return ConstantManager.hardSkill.count
        }else{
            return ConstantManager.softSkill.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hardSkillsCV{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
            cell.labelFilter.text = ConstantManager.hardSkill[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
            cell.labelFilter.text = ConstantManager.softSkill[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hardSkillsCV{
            if collectionView.cellForItem(at: indexPath)?.isSelected == true{
                tutor.tutorSkills.insert(ConstantManager.hardSkill[indexPath.row], at: 0)
            }
        }else{
            if collectionView.cellForItem(at: indexPath)?.isSelected == true{
                tutor.tutorSkills.insert(ConstantManager.softSkill[indexPath.row], at: 0)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            if selectedItems.contains(indexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
        }
        
        if collectionView == hardSkillsCV{
            if let index = ConstantManager.hardSkill.firstIndex(of: ConstantManager.hardSkill[indexPath.row]) {
                tutor.tutorSkills.remove(at: index)
            }
        }else{
            if let index = ConstantManager.softSkill.firstIndex(of: ConstantManager.softSkill[indexPath.row]) {
                tutor.tutorSkills.remove(at: index)
            }
        }
        return true
    }
    
    
}
