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
            labelResult.text = "Anda Berhasil Menerima Jadwal Tes Ini"
        } else if fromID == 2 {
            imageResult.image = imageAcc
            labelResult.text = """
            Anda Berhasil Meminta Jadwal Test Baru.
            Harap Menunggu Respon Dari Bimbel
            """
        } else if fromID == 3 {
            imageResult.image = imageAcc
            labelResult.text = "Teacher Accepted"
        } else if fromID == 4 {
            imageResult.image = imageDec
            labelResult.text = "Anda Telah Membatalkan Tes"
        } else if fromID == 5 {
            imageResult.image = imageDec
            labelResult.text = "Teacher Declined"
        } else if fromID == 6 {
            imageResult.image = imageSet
            labelResult.text = "Profile Updated"
            labelResultDescription.text = "You have filled your profile successfully."
            button.setTitle("Back to Home", for: .normal)
        }
        
    }
    
    
}
