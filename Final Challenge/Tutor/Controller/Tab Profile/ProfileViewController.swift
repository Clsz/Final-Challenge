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
    let header = "TitleTableViewCellID"
    let content = "ContentTableViewCellID"
    let anotherContent = "AnotherContentTableViewCellID"
    let achievement = "AchievementTableViewCellID"
    let contentView = "ContentViewTableViewCellID"
    let logoutView = "LogoutTableViewCellID"
    var sendToCustom:SendTutorToCustom?
    var dataArray:[Any?] = []
    var tutors:CKRecord?
    var education:CKRecord?
    var language:CKRecord?
    var experience:CKRecord?
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var isLoadedEducation:Bool?
    var isLoadedLanguage:Bool?
    var isLoadedExperience:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTutor()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Profile")
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
        //        let skill = (tutors?.value(forKey: "tutorSkills") as! [String])
        dataArray.append(("Skill","Add Skill",["skill","makan","tidur","boker"]))
        dataArray.append(("Language","Add Language",2))
        dataArray.append(("Education","Edit Education",0))
        dataArray.append(("Experience","Add Experience",1))
        //        dataArray.append(("Achievement","Add Achievement",2))
        dataArray.append(true)
    }
    
    func queryTutor() {
        let token = CKUserData.shared.getToken()
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            
            self.tutors = record[0]
            
            DispatchQueue.main.async {
                self.queryEducation()
                self.queryLanguage()
                self.queryExperience()
            }
        }
    }
    
    
    private func queryEducation() {
        let education = (tutors?.value(forKey: "educationID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: education.recordID.recordName))
        let query = CKQuery(recordType: "Education", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.education = record[0]
            DispatchQueue.main.async {
                self.isLoadedEducation = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func queryLanguage() {
        let language = (tutors?.value(forKey: "languageID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: language.recordID.recordName))
        let query = CKQuery(recordType: "Language", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.language = record[0]
            DispatchQueue.main.async {
                self.isLoadedLanguage = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func queryExperience() {
        let experience = (tutors?.value(forKey: "experienceID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: experience.recordID.recordName))
        let query = CKQuery(recordType: "Experience", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            self.experience = record[0]
            DispatchQueue.main.async {
                self.isLoadedExperience = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func checkIsLoaded() {
        if isLoadedEducation == true && isLoadedLanguage == true && isLoadedExperience == true{
            self.setupData()
            self.cellDelegate()
            self.tableView.reloadData()
        }
        
    }
    
    private func checkUniversity() -> String{
        let grade = education?.value(forKey: "grade") as! [String]
        let schoolName = education?.value(forKey: "schoolName") as! [String]
        var university:String = ""
        var id = 0
        
        for i in grade{
            id += 1
            if i == "University"{
                id -= 1
                university = schoolName[id]
            }
        }
        return university
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
        //            addAchievement()
        print("")
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
            // FOR TITLE
            let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleTableViewCell
//            let fName = (tutors?.value(forKey: "tutorFirstName") as! String) + (tutors?.value(forKey: "tutorLastName") as! String)
            let universityName = self.checkUniversity()
            
            let imageProfile = tutors?.value(forKey: "tutorProfileImage") as! UIImage
//            cell.setCell(image: imageProfile, name: fName, university: "Bina Nusantara", age: 22)
            cell.tutorDelegate = self
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, content:[String]){
            // FOR SKILLS
            let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! ContentTableViewCell
            cell.setCell(title: keyValue.key, button: keyValue.value)
            cell.tutorDelegate =  self
            cell.index = 0
            cell.skills = keyValue.content
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, button:String, value:Int){
            if keyValue.value == 0{
                // FOR EDUCATION
                let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                let schoolName = education?.value(forKey: "schoolName") as! [String]
                let grade = education?.value(forKey: "grade") as! [String]
                let fos = education?.value(forKey: "fieldOfStudy") as! [String]
                cell.index = 0
                cell.title = schoolName
                cell.content = grade
                cell.footer = fos
                cell.setCell(text: keyValue.key, button: keyValue.button)
                return cell
            } else if keyValue.value == 1{
                //FOR EXPERIENCE
                let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                let companyName = experience?.value(forKey: "jobCompanyName") as! [String]
                let jobTitle = experience?.value(forKey: "jobTitle") as! [String]
                let startYear = experience?.value(forKey: "jobStartYear") as! [String]
                let endYear = experience?.value(forKey: "jobEndYear") as! [String]
                cell.title = jobTitle
                cell.content = companyName
                cell.startYear = startYear
                cell.endYear = endYear
                cell.index = -1
                cell.setCell(text: keyValue.key, button: keyValue.button)
                return cell
            }else if keyValue.value == 2{
                //FOR LANGUAGE
                let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                let lang = language?.value(forKey: "languageName") as! [String]
                let level = language?.value(forKey: "languageLevel") as! [String]
                cell.index = 1
                cell.title = lang
                cell.content = level
                cell.setCell(text: keyValue.key, button: keyValue.button)
                return cell
            }else{
                //FOR LOGOUT
                let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
                cell.contentDelegate = self
                cell.setInterface()
                return cell
            }
        }
        return UITableViewCell()
    }
    
}


//            }
//            else if keyValue.code == 2{
//                let cell = tableView.dequeueReusableCell(withIdentifier: achievement, for: indexPath) as! AchievementTableViewCell
//                cell.setCell(label: keyValue.key, button: keyValue.value)
//                cell.contentDelegate = self
//                return cell
//            }





//    private func addAchievement() {
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let file = UIAlertAction(title: "Choose from file", style: .default) { action in
//
//            //Select from file
//        }
//
//        actionSheet.addAction(file)
//        actionSheet.addAction(cancel)
//
//        present(actionSheet, animated: true, completion: nil)
//    }
//        tableView.register(UINib(nibName: "AchievementTableViewCell", bundle: nil), forCellReuseIdentifier: achievement)
