//
//  SetupSkillTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 10/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupSkillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var choosenCV: UICollectionView!
    @IBOutlet weak var hardSkillCV: UICollectionView!
    @IBOutlet weak var softSkillCV: UICollectionView!
    let skillCell = "SkillCollectionViewCellID"
    var selectedHardSkills:[String] = []
    var selectedSoftSkills:[String] = []
    var selectedChoosenSkills:[String] = []
//    var selected:[Int] = []
    var delegate:refreshTableProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        softSkillCV.reloadData()
        hardSkillCV.reloadData()
        softSkillCV.allowsMultipleSelection = true
        hardSkillCV.allowsMultipleSelection = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension SetupSkillTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func cellDelegate() {
        softSkillCV.dataSource = self
        softSkillCV.delegate = self
        hardSkillCV.dataSource = self
        hardSkillCV.delegate = self
        choosenCV.dataSource = self
        choosenCV.delegate = self
    }
    
    func registerCell() {
        softSkillCV.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: skillCell)
        hardSkillCV.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: skillCell)
        choosenCV.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: skillCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.hardSkillCV){
            return ConstantManager.hardSkill.count
        } else if (collectionView == self.softSkillCV){
            return ConstantManager.softSkill.count
        } else {
            return selectedChoosenSkills.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.hardSkillCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            cell.labelSkill.text = ConstantManager.hardSkill[indexPath.row]
            
            return cell
        } else if (collectionView == self.softSkillCV){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            cell.labelSkill.text = ConstantManager.softSkill[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            cell.labelSkill.text = selectedChoosenSkills[indexPath.row]
            cell.layer.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
            cell.gambarSkill.image = #imageLiteral(resourceName: "tick")
            cell.labelSkill.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.softSkillCV {
            let index = collectionView.indexPathsForSelectedItems
            for i in index!{
                selectedChoosenSkills.insert(ConstantManager.softSkill[indexPath.row], at: 0)
                ConstantManager.softSkill.remove(at: i.row)
                
            }
            collectionView.reloadData()
            choosenCV.reloadData()
        } else {
            let index = collectionView.indexPathsForSelectedItems
            for i in index!{
                 selectedChoosenSkills.insert(ConstantManager.hardSkill[indexPath.row], at: 0)
                ConstantManager.hardSkill.remove(at: i.row)
            }
            collectionView.reloadData()
            choosenCV.reloadData()
        }
    }
    
    
}
