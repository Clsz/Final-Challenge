//
//  ProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:[Any?] = []
    var tutor:Tutor!
    let header = "TitleTableViewCellID"
    let content = "ContentTableViewCellID"
    let anotherContent = "AnotherContentTableViewCellID"
    let achievement = "AchievementTableViewCellID"
    let contentView = "ContentViewTableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        registerCell()
        cellDelegate()
        setupData()
        setupView(text: "Profile")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Profile")
    }
    
}

extension ProfileViewController{
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(tutor)
        dataArray.append(("Skill","Add Skill",0))
        dataArray.append(("Language","Add Language"))
        dataArray.append(("Education","Add Education",1))
        dataArray.append(("Experience","Add Experience"))
        dataArray.append(("Achievement","Add Achievement",2))
    }
    
    func getData() {
        self.tutor  = Tutor("01", "02", "jason@gmail.com", "12345", "Jason Valencius", "Wijaya", "", "082298222301", "Ruko Tol Boulevard Blok E No. 20-22, Jl. Pahlawan Seribu, Serpong, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15318 ", "Pria", "14/02/1997", ["Mobile Application","Algebra","Communication","Integrity","Geometry"], ["Junior Developer Academy","Teaching Assistant"], ["English","Mandarin"], [])
    }
    
}

extension ProfileViewController:SGProtocol{
    func skillTapped() {
        let destVC = SkillsViewController()
        destVC.tutor = self.tutor
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func languageTapped() {
        let destVC = LanguageViewController()
        destVC.tutor = self.tutor
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func educationTapped() {
        let destVC = EducationViewController()
        destVC.tutor = self.tutor
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func experienceTapped() {
        let destVC = ExperienceViewController()
        destVC.tutor = self.tutor
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func achievementTapped() {
        //Picker
    }
    
    func pencilTapped() {
        let destVC = EditProfileViewController()
        destVC.tutor = self.tutor
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension ProfileViewController:UITableViewDataSource, UITableViewDelegate{
    
    func registerCell() {
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: header)
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: content)
        tableView.register(UINib(nibName: "AnotherContentTableViewCell", bundle: nil), forCellReuseIdentifier: anotherContent)
        tableView.register(UINib(nibName: "AchievementTableViewCell", bundle: nil), forCellReuseIdentifier: achievement)
        tableView.register(UINib(nibName: "ContentViewTableViewCell", bundle: nil), forCellReuseIdentifier: contentView)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleTableViewCell
            if let tutor = dataArray[indexPath.row] as? Tutor {
                let fullName = tutor.tutorFirstName + " " + tutor.tutorLastName
                cell.setView(image: tutor.tutorImage, name: fullName, university: "Bina Nusantara", age: 22)
            }
            cell.contentDelegate = self
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! ContentTableViewCell
                cell.setView(title: keyValue.key, button: keyValue.value)
                cell.contentDelegate =  self
                return cell
            }else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentView, for: indexPath) as! ContentViewTableViewCell
                cell.setView(text: keyValue.key, button: keyValue.value)
                cell.contentDelegate = self
                return cell
            }else if keyValue.code == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: achievement, for: indexPath) as! AchievementTableViewCell
                cell.setView(label: keyValue.key, button: keyValue.value)
                cell.contentDelegate = self
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String){
            let cell = tableView.dequeueReusableCell(withIdentifier: anotherContent, for: indexPath) as! AnotherContentTableViewCell
            cell.setView(text: keyValue.key, button: keyValue.value)
            cell.customIndex = indexPath.row
            cell.contentDelegate = self
            return cell
        }
        return UITableViewCell()
    }
}

//    func getUser() {
//        let db = Firestore.firestore()
//
//        if let userID = Auth.auth().currentUser?.uid{
//            db.collection("Tutor").document(userID).getDocument { (document, err) in
//                if let document = document?.data(){
//
//                    let educationID = document["educationID"] as? String ?? ""
//                    let firstName = document["firstName"] as? String ?? ""
//                    let lastName = document["lastName"] as? String ?? ""
//                    let image = document["tutorImage"] as? String ?? ""
//                    let phoneNumber = document["tutorPhoneNumber"] as? String ?? ""
//                    let address = document["tutorAddress"] as? String ?? ""
//                    let gender = document["tutorGender"] as? String ?? ""
//                    let birthDate = document["tutorBirthDate"] as? String ?? ""
//                    let skills = document["tutorSkill"] as? [String] ?? []
//                    let experience = document["tutorExperience"] as? [String] ?? []
//                    let language = document["tutorLanguage"] as? [String] ?? []
//                    let achievement = document["tutorAchievement"] as? [String] ?? []
//                    self.tutor = Tutor(userID,educationID,firstName,lastName,image,phoneNumber,address, gender,birthDate,skills,experience,language,achievement)
//                    DispatchQueue.main.async {
//                        self.setupData()
//                        self.tableView.reloadData()
//                    }
//                } else {
//                    print("Document does not exist")
//                }
//            }
//        }
//    }
