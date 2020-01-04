//
//  Cloudkit.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 05/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import Foundation
import CloudKit

enum LoginResults {
    case userNotExist
    case userExists
    case passwordFails
    case loginSucceeds
}

struct User {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
}

class CKUserData {
    
    static let  shared = CKUserData()
    var users: [User] = []
    var privateDB : CKDatabase = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    
    private init() {
    }
    
    func loadUsers(email:String, password:String, completion: @escaping (Bool) -> Void){
        
        users = []
        
        print ("Load Cloudkit Users")
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Tutor", predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) {(records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else
                {
                    print ("No Records")
                    return
                }
                for record in records {
                    let firstName = record.object(forKey: "tutorFirstName") as! String
                    let lastName = record.object(forKey: "tutorLastName") as! String
                    let email = record.object(forKey: "tutorEmail") as! String
                    let password = record.object(forKey: "tutorPassword") as! String
                    self.addUser(firstName: firstName, lastName: lastName, email: email, password: password)
                }
                DispatchQueue.main.async {
                    if CKUserData.shared.checkUser(email: email) == LoginResults.userExists {
                        if CKUserData.shared.login(email: email, password: password) == .loginSucceeds {
                            self.setStatus(status: true)
                            completion(true)
                        } else { // Login Failed
                            self.setStatus(status: false)
                            completion(false)
                        }
                    }
                    
                }
            } else {
                print ("There Was an Error with CloudKit")
                print (error?.localizedDescription ?? "Error")
            }
        }
        
    }
    
    func loadUsersBimbel(email:String, password:String, completion: @escaping (Bool) -> Void){
        
        users = []
        
        print ("Load Cloudkit Users")
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Course", predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) {(records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else
                {
                    print ("No Records")
                    return
                }
                for record in records {
                    let email = record.object(forKey: "courseEmail") as! String
                    let password = record.object(forKey: "coursePassword") as! String
                    self.addUserBimbel(email: email, password: password)
                }
                DispatchQueue.main.async {
                    if CKUserData.shared.checkUser(email: email) == LoginResults.userExists {
                        if CKUserData.shared.login(email: email, password: password) == .loginSucceeds {
                            self.setStatus(status: true)
                            completion(true)
                        } else { // Login Failed
                            self.setStatus(status: false)
                            completion(false)
                        }
                    }
                    
                }
            } else {
                print ("There Was an Error with CloudKit")
                print (error?.localizedDescription ?? "Error")
            }
        }
        
    }
    
    func loadAllTutor(email:String, password:String, completion: @escaping (Bool) -> Void){
        users = []
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Tutor", predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) {(records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else
                {
                    print ("No Records")
                    return
                }
                self.users.removeAll()
                for record in records {
                    let email = record.object(forKey: "tutorEmail") as! String
                    let password = record.object(forKey: "tutorPassword") as! String
                    self.addUserBimbel(email: email, password: password)
                }
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                completion(false)
                print ("There Was an Error with CloudKit")
                print (error?.localizedDescription ?? "Error")
            }
        }
        
    }
    
    func loadAllBimbel(email:String, password:String, completion: @escaping (Bool) -> Void){
        users = []
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Course", predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) {(records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else
                {
                    print ("No Records")
                    return
                }
                self.users.removeAll()
                for record in records {
                    let email = record.object(forKey: "courseEmail") as! String
                    let password = record.object(forKey: "coursePassword") as! String
                    self.addUserBimbel(email: email, password: password)
                }
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                print ("There Was an Error with CloudKit")
                print (error?.localizedDescription ?? "Error")
            }
        }
        
    }
    
    func saveUsers(completion: @escaping (CKRecord) -> Void) {
        let record = CKRecord(recordType: "Tutor")
        for user in users {
            record.setObject(user.firstName as CKRecordValue? , forKey: "tutorFirstName")
            record.setObject(user.lastName as CKRecordValue?, forKey: "tutorLastName")
            record.setObject(user.email as CKRecordValue?, forKey: "tutorEmail")
            record.setObject(user.password as CKRecordValue? , forKey: "tutorPassword")
            privateDB.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                DispatchQueue.main.async {
                    guard let record = savedRecord else { return }
                    completion(record)
                }
            }
        }
    }
    
    func saveUsersBimbel(completion: @escaping (Bool) -> Void) {
        let record = CKRecord(recordType: "Course")
        for user in users {
            record.setObject(user.email as CKRecordValue?, forKey: "courseEmail")
            record.setObject(user.password as CKRecordValue? , forKey: "coursePassword")
            privateDB.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
    }
    
    func addUser(firstName: String, lastName: String, email: String, password: String){
        users.removeAll()
        
        let tempUser = User(firstName: firstName, lastName: lastName, email: email, password: password)
        users.append(tempUser)
    }
    
    func addUserBimbel(email: String, password: String){
        let tempUser = User(email: email, password: password)
        users.append(tempUser)
    }
    
    func testCloudKit() -> Bool {
        if let _ = FileManager.default.ubiquityIdentityToken {
            return true
        } else {
            return false
        }
    }
    
    func checkUser(email: String) -> LoginResults {
        if users.contains(where: {$0.email == email}) {
            return .userExists
        } else {
            return .userNotExist
        }
    }
    
    func login(email: String, password: String)->LoginResults {
        if let user = users.first(where: {$0.email == email}) {
            if user.password == password {
                return .loginSucceeds
            }
        }
        return .passwordFails
    }
    
    func setStatus(status: Bool) {
        UserDefaults.standard.set(status, forKey: "status")
        UserDefaults.standard.synchronize()
    }
    
    func getStatus() -> Bool{
        return UserDefaults.standard.bool(forKey: "status")
    }
    
    func saveToken(token:String){
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func getToken() -> String{
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    func setStatusBimbel(status: Bool) {
        UserDefaults.standard.set(status, forKey: "statusBimbel")
        UserDefaults.standard.synchronize()
    }
    
    func getStatusBimbel() -> Bool{
        return UserDefaults.standard.bool(forKey: "statusBimbel")
    }
    
    func saveTokenBimbel(token:String){
        UserDefaults.standard.set(token, forKey: "tokenBimbel")
    }
    
    func getTokenBimbel() -> String{
        return UserDefaults.standard.string(forKey: "tokenBimbel") ?? ""
    }
    
    func saveOnboardingStatus(status:String) {
        UserDefaults.standard.set(status, forKey: "isOnBoard")
    }
    
    func getOnBoardingStatus() -> String {
        return UserDefaults.standard.string(forKey: "isOnBoard") ?? ""
    }
}

