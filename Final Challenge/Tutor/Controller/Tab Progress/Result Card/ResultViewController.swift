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
    
    let imageAcc = UIImage(named: "Accepted")
    let imageDec = UIImage(named: "Decline")
    var fromID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setView() {
        if fromID == 0 {
            imageResult.image = imageAcc
            labelResult.text = """
            Success
            All the best for you
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
        }
        
    }
    
    
}
