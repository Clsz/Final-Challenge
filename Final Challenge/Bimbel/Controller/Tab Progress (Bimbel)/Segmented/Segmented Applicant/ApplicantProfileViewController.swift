//
//  ApplicantProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 12/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class ApplicantProfileViewController: UIViewController {

    var dataArray:[Any?] = []
    var applicant:CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
extension ApplicantProfileViewController{
    private func setupData() {
       dataArray.removeAll()
       dataArray.append(applicant)
       dataArray.append(("Keterampilan","Tambah Keterampilan",0))
       dataArray.append(("Bahasa","Tambah Bahasa"))
       dataArray.append(("Pendidikan","Edit Pendidikan",1))
       dataArray.append(("Pengalaman","Tambah Pengalaman"))
       dataArray.append(("Pencapaian","Tambah Pencapain",2))
       dataArray.append(false)
    }
    
    
}
