//
//  ChooseRoleViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 26/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ChooseRoleViewController: UIViewController {
    @IBOutlet weak var buttonTutor: UIButton!
    @IBOutlet weak var buttonTuition: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
    }
    
    @IBAction func tutorTapped(_ sender: UIButton) {
        
        let vc = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func tuitionTapped(_ sender: UIButton) {
        if CKUserData.shared.getEmailBimbel() != ""{
            let vc = TabBarBimbelController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }else{
            let rootVC = RegisterBimbelViewController()
            let navigationController = UINavigationController(rootViewController: rootVC)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
        }
        
    }
    
}
extension ChooseRoleViewController{
    func setInterface() {
        self.buttonTutor.loginRound()
        self.buttonTuition.loginRound()
    }
}
