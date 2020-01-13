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
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
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
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Profile")
        queryTutor()
        tableView.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.layer.removeAllAnimations()
        tableHeightConstraint.constant = tableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.view.updateConstraints()
            self.view.layoutIfNeeded()
        }
        
    }
    
}
extension ProfileViewController{
    private func setupData() {
        dataArray.removeAll()
        if self.tutors != nil{
            dataArray.append(tutors)
            dataArray.append(("Education","Edit Education",0))
            //            if let skill = (tutors?.value(forKey: "tutorSkills") as? [String]){
            //                dataArray.append(("Skill","Add Skill",skill))
            //            }else{
            //                dataArray.append(("Skill","Add Skill",[String]()))
            //
            //            }
            dataArray.append(("Skill","Edit Skill",3))
            dataArray.append(("Language","Edit Language",2))
            dataArray.append(("Experience","Edit Experience",1))
            dataArray.append(true)
        }else{
            dataArray.append("No Data")
        }
        
    }
    
    func queryTutor() {
        let token = CKUserData.shared.getEmail()
        let pred = NSPredicate(format: "tutorEmail == %@", token)
        let query = CKQuery(recordType: "Tutor", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            if record.count > 0{
                self.tutors = record[0]
            }
            DispatchQueue.main.async {
                //                if self.tutors != nil{
                //                    if self.tutors?.value(forKey: "educationID") != nil{
                //                        self.queryEducation()
                //                    }
                //                    if self.tutors?.value(forKey: "languageID") != nil{
                //                        self.queryLanguage()
                //                    }
                //                    if self.tutors?.value(forKey: "experienceID") != nil{
                //                        self.queryExperience()
                //                    }
                //                    self.refresh()
                //                }else{
                //                    self.refresh()
                //                }
                if self.tutors != nil{
                    self.queryEducation()
                    self.queryLanguage()
                    self.queryExperience()
                }else{
                    self.refresh()
                }
            }
        }
    }
    
    
    private func queryEducation() {
        let education = (tutors?.value(forKey: "educationID") as! CKRecord.Reference)
        let pred = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: education.recordID.recordName))
        let query = CKQuery(recordType: "Education", predicate: pred)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records else {return}
            if record.count > 0 {
                self.education = record[0]
            }
            DispatchQueue.main.async {
                //                self.refresh()
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
            if record.count > 0 {
                self.language = record[0]
            }
            DispatchQueue.main.async {
                //                self.refresh()
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
            if record.count > 0{
                self.experience = record[0]
            }
            DispatchQueue.main.async {
                //                self.refresh()
                self.isLoadedExperience = true
                self.checkIsLoaded()
            }
        }
    }
    
    private func refresh() {
        self.setupData()
        self.cellDelegate()
        self.tableView.reloadData()
    }
    
    private func checkIsLoaded() {
        if isLoadedEducation == true && isLoadedLanguage == true && isLoadedExperience == true{
            self.setupData()
            self.cellDelegate()
            self.tableView.reloadData()
        }
        
    }
    
    private func checkUniversity() -> String{
        if education != nil{
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
        return ""
    }
    
    private func showLogoutAllert() {
        let confirmAlert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action: UIAlertAction!) in  
               }))
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
           CKUserData.shared.setStatus(status: false)
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let vc = LoginViewController()
           let navigationController = UINavigationController(rootViewController: vc)
           appDelegate.window?.rootViewController = navigationController
           appDelegate.window?.makeKeyAndVisible()
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
}
extension ProfileViewController:ProfileProtocol, LanguageViewControllerDelegate, setAccount{
    func setAccountTapped() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
        self.showAlert(title: "Under Construction", message: "We're very sorry that you can't edit your skill's preference right now")
    }
    
    func languageTapped() {
//        let destVC = LanguageViewController()
//
//        destVC.delegate = self
//        navigationController?.pushViewController(destVC, animated: true)
        self.showAlert(title: "Under Construction", message: "We're very sorry that you can't edit your language's preference right now")
    }
    
    func educationTapped() {
        if education != nil {
            let destVC = ListEducationViewController()
            destVC.tutors = self.tutors
            destVC.delegate = self
            navigationController?.pushViewController(destVC, animated: true)
        } else {
            let lastVC = AdditionalEducationViewController()
            lastVC.flag = false
            let destVC = SetupEducationViewController()
            destVC.additionalEducation = lastVC
            destVC.tutors = self.tutors
            navigationController?.pushViewController(destVC, animated: true)
        }
        
    }
    
    func experienceTapped() {
//        let destVC = ExperienceViewController()
//
//        destVC.delegate = self
//        navigationController?.pushViewController(destVC, animated: true)
        self.showAlert(title: "Under Construction", message: "We're very sorry that you can't edit your experience's preference right now")
    }
    
    func achievementTapped() {
        //            addAchievement()
        print("")
    }
    
    func logout() {
        showLogoutAllert()
    }
    
}
extension ProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func registerCell() {
        tableView.register(UINib(nibName: "NoAccountTutorTableViewCell", bundle: nil), forCellReuseIdentifier: "NoAccountTutorTableViewCellID")
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
        if tutors != nil{
            if indexPath.row == 0{
                // FOR TITLE
                let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleTableViewCell
                if (tutors?.value(forKey: "tutorFirstName") as? String) != nil{
                    let fName = "\(tutors?.value(forKey: "tutorFirstName") as! String) \(tutors?.value(forKey: "tutorLastName") as! String)"
                    let universityName = self.checkUniversity()
                    let imageDefault = #imageLiteral(resourceName: "user-5")
                    cell.index = 0
                    if tutors?.value(forKeyPath: "tutorProfilImage") != nil {
                        let imageProfile = tutors?.value(forKey: "tutorProfileImage") as! CKAsset
                        cell.setCell(image: imageProfile.toUIImage()!, name: fName, university: universityName, age: 22)
                        cell.tutorDelegate = self
                        return cell
                    } else {
                        cell.setCell(image: imageDefault, name: fName, university: universityName, age: 22)
                        cell.tutorDelegate = self
                        return cell
                    }
                }
            }else if let keyValue = dataArray[indexPath.row] as? (key:String, button:String, value:Int){
                if keyValue.value == 0{
                    // FOR EDUCATION
                    if self.education != nil {
                        let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                        let schoolName = education?.value(forKey: "schoolName") as! [String]
                        let grade = education?.value(forKey: "grade") as! [String]
                        let fos = education?.value(forKey: "fieldOfStudy") as! [String]
                        cell.index = 1
                        cell.destIndex = 2
                        cell.title = schoolName
                        cell.content = grade
                        cell.footer = fos
                        cell.setCell(text: keyValue.key, button: keyValue.button)
                        cell.contentDelegate = self
                        //                        cell.content = education?.value(forKey: "schoolName") as? [String]
                        cell.cellDelegate()
                        
                        
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                        cell.setCell(text: keyValue.key, button: keyValue.button)
                        cell.contentDelegate = self
                        return cell
                    }
                } else if keyValue.value == 1{
                    //FOR EXPERIENCE
                    if self.experience != nil {
                        let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                        let companyName = experience?.value(forKey: "jobCompanyName") as! [String]
                        let jobTitle = experience?.value(forKey: "jobTitle") as! [String]
                        let startYear = experience?.value(forKey: "jobStartYear") as! [String]
                        let endYear = experience?.value(forKey: "jobEndYear") as! [String]
                        cell.title = jobTitle
                        cell.content = companyName
                        cell.startYear = startYear
                        cell.endYear = endYear
                        cell.index = 0
                        cell.destIndex = 1
                        cell.setCell(text: keyValue.key, button: keyValue.button)
                        cell.contentDelegate = self
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                        cell.setCell(text: keyValue.key, button: keyValue.button)
                        cell.contentDelegate = self
                        return cell
                    }
                }else if keyValue.value == 2{
                    //FOR LANGUAGE
                    if self.language != nil {
                        let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                        let lang = language?.value(forKey: "languageName") as! [String]
                        let level = language?.value(forKey: "languageLevel") as! [String]
                        cell.index = 1
                        cell.destIndex = 0
                        cell.title = lang
                        cell.content = level
                        cell.setCell(text: keyValue.key, button: keyValue.button)
                        cell.contentDelegate = self
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
                        cell.setCell(text: keyValue.key, button: keyValue.button)
                        cell.contentDelegate = self
                        return cell
                    }
                }else if keyValue.value == 3 {
                    //FOR SKILL
                    if tutors?.value(forKey: "tutorSkills") != nil{
                        let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! ContentTableViewCell
                        let skill = (tutors?.value(forKey: "tutorSkills") as? [String])
                        cell.setCell(title: keyValue.key, button: keyValue.button)
                        cell.tutorDelegate =  self
                        cell.index = 0
                        cell.skills = skill
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! ContentTableViewCell
                        cell.setCell(title: keyValue.key, button: keyValue.button)
                        cell.collectionView.isHidden = true
                        cell.tutorDelegate =  self
                        return cell
                    }
                }
                
            }else {
                //FOR LOGOUT
                let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
                cell.contentDelegate = self
                cell.index = 0
                cell.setInterfaceLogOut()
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoAccountTutorTableViewCellID", for: indexPath) as! NoAccountTutorTableViewCell
            cell.delegate = self
            cell.setInterface()
            return cell
        }
        return UITableViewCell()
    }
    
}
