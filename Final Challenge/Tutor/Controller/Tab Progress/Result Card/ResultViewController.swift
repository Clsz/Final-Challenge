//
//  ResultViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var imageResult: UIImageView!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelResultDescription: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let imageAcc = UIImage(named: "Accepted")
    let imageDec = UIImage(named: "Decline")
    let imageSet = UIImage(named: "profilDone")
    var fromID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if fromID == 6 {
            let vc = TabBarController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func setView() {
        button.loginRound()
        if fromID == 0 {
            imageResult.image = imageAcc
            labelResult.text = "Applied Success"
            labelResultDescription.text = """
            We have sent your profile details to the Course.
            Please wait for their response.
            """
        } else if fromID == 1 {
            imageResult.image = imageAcc
            labelResult.text = "You Accept the Interview"
            labelResultDescription.text = "You have accepted the interview schedule with the Course. Do not miss the date. "
        } else if fromID == 2 {
            imageResult.image = imageAcc
            labelResult.text = "New Schedule Requested"
            labelResultDescription.text = "We have sent your reschedule request to the Course. Please wait for their response."
        } else if fromID == 3 {
            imageResult.image = imageAcc
            labelResult.text = "Teacher Accepted"
        } else if fromID == 4 {
            imageResult.image = imageDec
            labelResult.text = "You Decline the Interview"
            labelResultDescription.text = "You have declined this interview schedule with the Course. You skip this job."
        } else if fromID == 5 {
            imageResult.image = imageDec
            labelResult.text = "Teacher Declined"
        } else if fromID == 6 {
            imageResult.image = imageSet
            labelResult.text = "Profile Updated"
            labelResultDescription.text = "You have filled your profile successfully."
            button.setTitle("Back to Home", for: .normal)
        } else if fromID == 7 {
        imageResult.image = imageAcc
        labelResult.text = "Test Schedule Submitted"
            labelResultDescription.text = "You have successfully submit the test schedule. Please wait for the Applicant to response."
        }
    }
    
    
}
