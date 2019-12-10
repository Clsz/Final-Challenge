//
//  SetupSkillTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 10/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupSkillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hardSkillCV: UICollectionView!
    @IBOutlet weak var softSkillCV: UICollectionView!
    let filterCell = "filterCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        softSkillCV.reloadData()
        hardSkillCV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension SetupSkillTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func cellDelegate() {
        softSkillCV.delegate = self
        softSkillCV.delegate = self
        hardSkillCV.delegate = self
        hardSkillCV.delegate = self
    }
    
    func registerCell() {
        softSkillCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
        hardSkillCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.hardSkillCV){
            return ConstantManager.hardSkill.count
        } else {
            return ConstantManager.softSkill.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.hardSkillCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell

            cell.labelFilter.text = ConstantManager.hardSkill[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
            
            cell.labelFilter.text = ConstantManager.softSkill[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
    
}
