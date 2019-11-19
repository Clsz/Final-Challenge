//
//  SecondTabViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SecondTabViewController: UIViewController {

    @IBOutlet weak var secondTabTV: UITableView!
    
    var activity:[Activity] = []
//    let images = UIImage(named: "school")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        secondTabTV.reloadData()
        initializeData()
    }
}

extension SecondTabViewController {
    func initializeData() {
        let dataTab2Pertama: Activity = Activity("01", "STATUS: TES DIBATALKAN", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
                                                 """
        - Harap Membawa KTP
        - Lampirkan CV
        - Kenakan Baju Kemeja Putih
        ""","01", "Next Level Bimbel", "BSD Anggrek Loka Jalan Anggrek Ungu Blok A No 1A Sektor 2-1 Serpong, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15310", "Kota Tangerang Selatan", "", 2000000, 3000000, ["09.00 A.M - 08.00 PM", "01.00 PM - 04.00 PM"], ["Everyday", "Everyday"], ["Matematika", "IPA", "IPS"],
            """
        - Pendidikan minimal SMA/sederajat
        - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
        - Jujur, pekerja keras, rajin dan tanggung jawab
        - Komitmen mengajar selama minimal 6 bulan
        - Memiliki kesabaran terhadap anak-anak
        """, ["SD"])
        
        let dataTab2Kedua: Activity = Activity("02", "STATUS: MENUNGGU TES", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
                                               """
        - Harap Membawa KTP
        - Lampirkan CV
        - Kenakan Baju Kemeja Putih
        ""","02", "Smart Mandarin Bimbel", "Ruko Crystal 1, No. 76 Jl. Boulevard Gading Serpong, Serpong Utara, Tangerang", "Kota Tangerang Selatan", "", 2500000, 3500000, ["10.00 A.M - 07.00 PM"], ["Everyday"], ["Mandarin"],
            """
        - Minimal bisa membaca, menulis dan mendengar mandarin SD
        - Lebih disukai yang memiliki pengalaman mengajar mandarin sebelumnya
        - Lebih disukai yang menyukai anak-anak
        - Memiliki kesabaran yang tinggi
        - Rajin, jujur dan tanggung jawab
        """, ["SD", "SMP"])
        
        let dataTab2Ketiga: Activity = Activity("03", "STATUS: MEMINTA JADWAL TES BARU", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
                                                """
        - Harap Membawa KTP
        - Lampirkan CV
        - Kenakan Baju Kemeja Putih
        ""","04", "Bimbel Salembra Group(SG)", "Ruko Tol Boulevard Blok D Nomor 3 Jalan Pahlawan Seribu, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15417", "Kota Tangerang Selatan", "", 1500000, 2500000, ["02.00 P.M - 06.00 PM", "03.00 P.M - 07.00"], ["Senin", "Rabu"], ["Matematika", "Fisika", "Kimia", "IPS", "IPA"],
            """
        - Berintegritas
        - Disiplin
        - Professional
        - Mencintai dunia pendidikan
        """, ["SD", "SMP", "SMA"])
        
        activity = [dataTab2Pertama, dataTab2Kedua, dataTab2Ketiga]
    }
}

extension SecondTabViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        let data = activity[indexPath.row]
        cell.setView(image: "", nama: data.courseName, status: data.activityStatus)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destVC = DetailBimbelViewController()
//        print(bimbel[indexPath.row])
//        destVC.course = bimbel[indexPath.row]
//        navigationController?.pushViewController(destVC, animated: true)
//    }
    
    func cellDelegate(){
        secondTabTV.dataSource = self
        secondTabTV.delegate = self
    }
    
    func registerCell() {
        secondTabTV.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "progressCell")
    }
    
}
