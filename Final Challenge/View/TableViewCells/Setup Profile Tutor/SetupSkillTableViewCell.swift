//
//  SetupSkillTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 10/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class SetupSkillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hardSkillCV: UICollectionView!
    @IBOutlet weak var softSkillCV: UICollectionView!
    let skillCell = "SkillCollectionViewCellID"
    var selectedChoosenSkills:[(key:Int, value:String)] = [(key:Int,value:String)]()
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var sendFlagDelegate:SendFlag?
    var reloadDelegate:ChooseSkillProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        flushArray()
        softSkillCV.reloadData()
        hardSkillCV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
extension SetupSkillTableViewCell{
    private func flushArray() {
        selectedChoosenSkills.removeAll()
    }
    
}
extension SetupSkillTableViewCell:ChooseSkillProtocol{
    func passData(dataSkills: [(key: Int, value: String)]) {
        self.selectedChoosenSkills = dataSkills
    }
    
    func reloadCV() {
        self.hardSkillCV.reloadData()
        self.softSkillCV.reloadData()
    }
}
extension SetupSkillTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func cellDelegate() {
        softSkillCV.dataSource = self
        softSkillCV.delegate = self
        hardSkillCV.dataSource = self
        hardSkillCV.delegate = self
    }
    
    func registerCell() {
        softSkillCV.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: skillCell)
        hardSkillCV.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: skillCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.hardSkillCV){
            return ConstantManager.hardSkill.count
        } else{
            return ConstantManager.softSkill.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.hardSkillCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            let data:(key:Int,value:String) = ConstantManager.hardSkill[indexPath.row]
            
            cell.labelSkill.text = data.value
            
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            let data:(key:Int,value:String) = ConstantManager.softSkill[indexPath.row]
            
            cell.labelSkill.text = data.value
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedChoosenSkills.count == 0{
            sendFlagDelegate?.sendFlag(flag: true)
            
        }
        if collectionView == self.softSkillCV {
            selectedChoosenSkills.insert(ConstantManager.softSkill[indexPath.row], at: 0)
            ConstantManager.softSkill.remove(at: indexPath.row)
            reloadDelegate?.reloadCV()
            collectionView.reloadData()
        } else if collectionView == self.hardSkillCV{
            selectedChoosenSkills.insert(ConstantManager.hardSkill[indexPath.row], at: 0)
            ConstantManager.hardSkill.remove(at: indexPath.row)
            reloadDelegate?.reloadCV()
            collectionView.reloadData()
            
        }
//        reloadDelegate?.passData(dataSkills: selectedChoosenSkills)
    }
    
}
//extension SetupSkillTableViewCell{
//    private func getDataCustomCell() {
//        let index = IndexPath(row: 0, section: 0)
//        let cell = tableView.cellForRow(at: index) as! SetupPersonalTableViewCell
//
//        fullNames = cell.nameTF.text ?? ""
//        arrName = fullNames?.components(separatedBy: " ")
//
//        self.updateUser(name: cell.nameTF.text ?? "", age: cell.ageTF.text ?? "", address: cell.addressTF.text ?? "")
//    }
//
//    func updateUser(skill:[String]){
//           if let record = tutors{
//               record["tutorSkills"] = selectedChoosenSkills
//
//
//               self.database.save(record, completionHandler: {returnRecord, error in
//                   if error != nil
//                   {
//                       print("error")
//                   } else{
//                   }
//               })
//           }
//       }
//}
