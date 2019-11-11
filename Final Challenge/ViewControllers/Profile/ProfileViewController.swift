//
//  ProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    var tutor:Tutor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        self.setupData()
        self.registerCell()
        self.cellDelegate()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
    }
    
    func setView() {
        self.navigationItem.title = "Profile"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupData() {
        dataArray.removeAll()
        dataArray.append(tutor)
        dataArray.append(("Address",false))
        dataArray.append(("Skill",true))
        dataArray.append(("Language",true))
        dataArray.append(("Education",true))
        dataArray.append(("Experience",true))
        dataArray.append(("Achievement",1))
    }

    func getUser() {
        let db = Firestore.firestore()
        
        if let userID = Auth.auth().currentUser?.uid{
            db.collection("Tutor").document(userID).getDocument { (document, err) in
                if let document = document?.data(){
                    
                    let educationID = document["educationID"] as? String ?? ""
                    let firstName = document["firstName"] as? String ?? ""
                    let lastName = document["lastName"] as? String ?? ""
                    let image = document["tutorImage"] as? String ?? ""
                    let phoneNumber = document["tutorPhoneNumber"] as? String ?? ""
                    let address = document["tutorAddress"] as? String ?? ""
                    let gender = document["tutorGender"] as? String ?? ""
                    let birthDate = document["tutorBirthDate"] as? String ?? ""
                    let skills = document["tutorSkill"] as? [String] ?? []
                    let experience = document["tutorExperience"] as? [String] ?? []
                    let language = document["tutorLanguage"] as? [String] ?? []
                    let achievement = document["tutorAchievement"] as? [String] ?? []
                    self.tutor = Tutor(userID,educationID,firstName,lastName,image,phoneNumber,address, gender,birthDate,skills,experience,language,achievement)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }

    
    
}
extension ProfileViewController:UITableViewDataSource, UITableViewDelegate{
    
    func registerCell() {
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "titleTableHeaderCellID")
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentTableViewCellID")
        tableView.register(UINib(nibName: "AnotherContentTableViewCell", bundle: nil), forCellReuseIdentifier: "anotherContentTableViewCellID")
        tableView.register(UINib(nibName: "AchievementTableViewCell", bundle: nil), forCellReuseIdentifier: "achievementTableViewCellID")
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleTableHeaderCellID", for: indexPath) as! TitleTableViewCell
            if let tutor = dataArray[indexPath.row] as? Tutor {
                let fullName = tutor.tutorFirstName + " " + tutor.tutorLastName
                cell.setView(image: tutor.tutorImage, name: fullName, university: "Bina Nusantara", age: 21)
            }
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:Bool){
            if keyValue.value == false{
                let cell = tableView.dequeueReusableCell(withIdentifier: "contentTableViewCellID", for: indexPath) as! ContentTableViewCell
                cell.setView(title: keyValue.key)
                return cell
            }else if keyValue.value == true{
                let cell = tableView.dequeueReusableCell(withIdentifier: "anotherContentTableViewCellID", for: indexPath) as! AnotherContentTableViewCell
                cell.setView(text: keyValue.key)
                return cell
            }
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:Int){
            if keyValue.value == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "achievementTableViewCellID", for: indexPath) as! AchievementTableViewCell
                
                return cell
            }
        }
        return UITableViewCell()
    }
}
