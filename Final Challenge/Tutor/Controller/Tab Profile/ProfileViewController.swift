//
//  ProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    var tutors:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    let header = "TitleTableViewCellID"
    let content = "ContentTableViewCellID"
    let anotherContent = "AnotherContentTableViewCellID"
    let achievement = "AchievementTableViewCellID"
    let contentView = "ContentViewTableViewCellID"
    let logoutView = "LogoutTableViewCellID"
    var sendToCustom:SendTutorToCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sendToCustom?.sendTutor(tutor: self.tutorModel)
        queryUser()
        setupData()
        registerCell()
//        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Profil")
        setupData()
        registerCell()
        cellDelegate()
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = true
    }
    
}
extension ProfileViewController{
    private func setupData() {
        dataArray.removeAll()
        dataArray.append(tutors)
        dataArray.append(("Skill","Add Skill",0))
        dataArray.append(("Language","Add Language"))
        dataArray.append(("Education","Edit Education",1))
        dataArray.append(("Experience","Add Experience"))
        dataArray.append(("Achievement","Add Achievement",2))
        dataArray.append(false)
    }
    
    private func addAchievement() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let file = UIAlertAction(title: "Choose from file", style: .default) { action in
            
            //Select from file
        }
        
        actionSheet.addAction(file)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func queryUser() {
        let token = CKUserData.shared.getToken()
        
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            
            self.tutors = record[0]
            DispatchQueue.main.async {
                self.cellDelegate()
            }
        }
    }
    
}
extension ProfileViewController:ProfileProtocol, LanguageViewControllerDelegate{
    
    func refreshData(withTutorModel: Tutor) {
        
        setupData()
        tableView.reloadData()
    }
    
    func pencilTapped() {
        let destVC = EditProfileViewController()
        destVC.tutors = self.tutors
        destVC.delegate = self
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func skillTapped() {
//        let destVC = SkillsViewController()
//
//        destVC.delegate = self
//        navigationController?.pushViewController(destVC, animated: true)
        print("")
    }
    
    func languageTapped() {
        let destVC = LanguageViewController()
        
        destVC.delegate = self
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func educationTapped() {
        let destVC = EducationViewController()
        
        destVC.delegate = self
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func experienceTapped() {
        let destVC = ExperienceViewController()
        
        destVC.delegate = self
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func achievementTapped() {
        addAchievement()
    }
    
    func logout() {
        CKUserData.shared.setStatus(status: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = LoginViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
extension ProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func registerCell() {
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: header)
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: content)
        tableView.register(UINib(nibName: "AnotherContentTableViewCell", bundle: nil), forCellReuseIdentifier: anotherContent)
        tableView.register(UINib(nibName: "AchievementTableViewCell", bundle: nil), forCellReuseIdentifier: achievement)
        tableView.register(UINib(nibName: "ContentViewTableViewCell", bundle: nil), forCellReuseIdentifier: contentView)
        tableView.register(UINib(nibName: "LogoutTableViewCell", bundle: nil), forCellReuseIdentifier: logoutView)
    }
    
    private func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleTableViewCell
            let fName = "\(tutors?.value(forKey: "tutorFirstName") as! String) \(tutors?.value(forKey: "tutorLastName") as! String)"
            let imageProfile = tutors?.value(forKey: "tutorProfileImage") as! UIImage
            cell.setCell(image: imageProfile, name: fName, university: "Bina Nusantara", age: 22)
            cell.tutorDelegate = self
                   return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! ContentTableViewCell
                cell.setCell(title: keyValue.key, button: keyValue.value)
                cell.tutorDelegate =  self
                return cell
            }else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentView, for: indexPath) as! ContentViewTableViewCell
                cell.setCell(text: keyValue.key, button: keyValue.value)
                cell.tutorDelegate = self
                return cell
            }else if keyValue.code == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: achievement, for: indexPath) as! AchievementTableViewCell
                cell.setCell(label: keyValue.key, button: keyValue.value)
                cell.contentDelegate = self
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String){
            let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
            cell.setCell(text: keyValue.key, button: keyValue.value)
            cell.customIndex = indexPath.row
            print(indexPath.row)
            cell.contentDelegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
            cell.contentDelegate = self
            cell.setInterface()
            return cell
        }
        return UITableViewCell()
    }
    
}
