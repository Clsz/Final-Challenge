//
//  ThirdTabViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ThirdTabViewController: UIViewController {

    @IBOutlet weak var thirdTabTV: UITableView!
    var activity:[Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        thirdTabTV.reloadData()
        initializeData()

        
    }

}

extension ThirdTabViewController {
    func initializeData() {
          let dataTab3Pertama: Activity = Activity("01", "STATUS: DITERIMA", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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

        let dataTab3Kedua: Activity = Activity("02", "STATUS: DITERIMA", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
                                                """
            - Harap Membawa KTP
            - Lampirkan CV
            - Kenakan Baju Kemeja Putih
            ""","06", "Level One Bimbel", "Jl. Bangun Nusa Raya No.9, RT.9/RW.2, Cengkareng Tim., Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730", "Jakarta Barat", "", 2000000, 4000000, ["07.00 A.M - 12.00 PM", "07.00 A.M - 12.00 PM"], ["Senin", "Selasa"], ["Matematika"],
            """
            - Pendidikan minimal SMA/sederajat
            - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
            - Jujur, pekerja keras, rajin dan tanggung jawab
            - Komitmen mengajar selama minimal 6 bulan
            - Memiliki kesabaran terhadap anak-anak
            """, ["SMP"])

        let dataTab3Ketiga: Activity = Activity("03", "STATUS: DITOLAK", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
                                                """
            - Harap Membawa KTP
            - Lampirkan CV
            - Kenakan Baju Kemeja Putih
            ""","07", "One Two Bimbel", "Rusun Cengkareng, Blok Seruni 6 Lt. Dasar, Jl. Kamal Raya, RT.14/RW.10, Cengkareng Barat, Cengkareng, RT.10/RW.10, Cengkareng Tim., Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730", "Jakarta Barat", "", 2000000, 3500000, ["02.00 P.M - 06.00 PM", "03.00 P.M - 07.00 PM"], ["Senin", "Rabu"], ["IPA"],
            """
            - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
            - Jujur, pekerja keras, rajin dan tanggung jawab
            - Komitmen mengajar selama minimal 1 tahun
            - Memiliki kesabaran terhadap anak-anak
            """, ["SD"])
        
        activity = [dataTab3Pertama, dataTab3Kedua, dataTab3Ketiga]
    }
}

extension ThirdTabViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        let data = activity[indexPath.row]
        print(data)
        cell.setView(image: "school", nama: data.courseName, status: data.activityStatus)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destVC = DetailBimbelViewController()
//        print(bimbel[indexPath.row])
//        destVC.course = bimbel[indexPath.row]
//        navigationController?.pushViewController(destVC, animated: true)
//    }
    
    func cellDelegate(){
        thirdTabTV.dataSource = self
        thirdTabTV.delegate = self
    }
    
    func registerCell() {
        thirdTabTV.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "progressCell")
    }
    
}
