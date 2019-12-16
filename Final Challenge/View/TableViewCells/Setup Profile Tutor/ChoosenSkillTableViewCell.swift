//
//  ChoosenSkillTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 10/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ChoosenSkillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var choosenCV: UICollectionView!
    let skillCell = "SkillCollectionViewCellID"
    var selectedChoosenSkills:[(key:Int, value:String)] = [(key:Int,value:String)]()
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var chooseDelegate:ChooseSkillProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        flushArray()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension ChoosenSkillTableViewCell:ChooseSkillProtocol{
    func passData(dataSkills: [(key: Int, value: String)]) {
        self.selectedChoosenSkills = dataSkills
    }
    
    func reloadCV() {
        self.choosenCV.reloadData()
    }
    
}
extension ChoosenSkillTableViewCell{
    private func flushArray() {
        selectedChoosenSkills.removeAll()
    }
    
    private func reloadCollectionView() {
        chooseDelegate?.reloadCV()
        choosenCV.reloadData()
    }
}
extension ChoosenSkillTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func cellDelegate() {
        choosenCV.dataSource = self
        choosenCV.delegate = self
    }
    
    func registerCell() {
        choosenCV.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: skillCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedChoosenSkills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
        if selectedChoosenSkills.count > 0{
            cell.labelSkill.text = selectedChoosenSkills[indexPath.row].value
            cell.layer.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
            cell.gambarSkill.image = #imageLiteral(resourceName: "tick")
            cell.labelSkill.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = selectedChoosenSkills[indexPath.row].key
        if data == 0{
            ConstantManager.softSkill.insert(selectedChoosenSkills[indexPath.row], at: 0)
            selectedChoosenSkills.remove(at: indexPath.row)
            self.reloadCollectionView()
        }else{
            ConstantManager.hardSkill.insert(selectedChoosenSkills[indexPath.row], at: 0)
            selectedChoosenSkills.remove(at: indexPath.row)
            self.reloadCollectionView()
        }
        chooseDelegate?.passData(dataSkills: selectedChoosenSkills)
    }
    
}
