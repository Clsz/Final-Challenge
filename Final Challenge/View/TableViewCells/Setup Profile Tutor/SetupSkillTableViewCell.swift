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
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var choosenCV: UICollectionView!
    @IBOutlet weak var hardSkillCV: UICollectionView!
    @IBOutlet weak var softSkillCV: UICollectionView!
    let skillCell = "SkillCollectionViewCellID"
    var selectedChoosenSkills:[(key:Int, value:String)] = [(key:Int,value:String)]()
    var sel:[String] = [String]()
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        flushArray()
        setInterface()
        softSkillCV.reloadData()
        hardSkillCV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func applyTapped(_ sender: UIButton) {
        updateSkill()
    }
}
extension SetupSkillTableViewCell{
    private func setInterface() {
        applyButton.outerRound()
    }
    private func flushArray() {
        selectedChoosenSkills.removeAll()
    }
    
    func updateSkill(){
             if let record = tutors{
                 getData()
                 record["tutorSkill"] = sel
                 
                 self.database.save(record, completionHandler: {returnRecord, error in
                     if error != nil
                     {
                         print("error")
                     } else{
                     }
                 })
             }
         }
    
    private func getData() {
        for i in selectedChoosenSkills{
            sel.append(i.value)
        }
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
        } else{
            return selectedChoosenSkills.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.hardSkillCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            let data:(key:Int,value:String) = ConstantManager.hardSkill[indexPath.row]
            
            cell.labelSkill.text = data.value
            
            return cell
        } else if (collectionView == self.softSkillCV){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            
            let data:(key:Int,value:String) = ConstantManager.softSkill[indexPath.row]
            
            cell.labelSkill.text = data.value
            
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SkillCollectionViewCell
            if selectedChoosenSkills.count > 0{
                cell.labelSkill.text = selectedChoosenSkills[indexPath.row].value
                cell.layer.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
                cell.gambarSkill.image = #imageLiteral(resourceName: "tick")
                cell.labelSkill.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
                return cell
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 180, height: 44)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == self.softSkillCV {
                selectedChoosenSkills.insert(ConstantManager.softSkill[indexPath.row], at: 0)
                ConstantManager.softSkill.remove(at: indexPath.row)
                collectionView.reloadData()
                choosenCV.reloadData()
            } else if collectionView == self.hardSkillCV{
                selectedChoosenSkills.insert(ConstantManager.hardSkill[indexPath.row], at: 0)
                ConstantManager.hardSkill.remove(at: indexPath.row)
                collectionView.reloadData()
                choosenCV.reloadData()
            } else{
                let data = selectedChoosenSkills[indexPath.row].key
                if data == 0{
                    ConstantManager.softSkill.insert(selectedChoosenSkills[indexPath.row], at: 0)
                    selectedChoosenSkills.remove(at: indexPath.row)
                    choosenCV.reloadData()
                    softSkillCV.reloadData()
                    hardSkillCV.reloadData()
                }else{
                    ConstantManager.hardSkill.insert(selectedChoosenSkills[indexPath.row], at: 0)
                    selectedChoosenSkills.remove(at: indexPath.row)
                    choosenCV.reloadData()
                    softSkillCV.reloadData()
                    hardSkillCV.reloadData()
                }
            }
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


//        if selectedChoosenSkills.count == 0{
//            sendFlagDelegate?.sendFlag(flag: true)
//
//        }
