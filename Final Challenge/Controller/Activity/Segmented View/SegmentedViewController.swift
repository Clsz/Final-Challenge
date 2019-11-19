//
//  SegmentedViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SegmentedViewController: BaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var activity:[[Activity]]?
    var detailActivity1:[Activity]?
    var detailActivity2:[Activity]?
    var detailActivity3:[Activity]?
    var currentTableView:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableView = 0
        initializeData()
        registerCell()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Progres")
        tableView.reloadData()
    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
}

extension SegmentedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity![currentTableView].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressTableViewCell
        cell.setView(image: "", nama: activity![currentTableView][indexPath.row].courseName, status: activity![currentTableView][indexPath.row].activityStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentTableView == 0{
            //Send data informasi ke VC Segmented 1
            let destVC = DetailBimbelTabFirstViewController()
            destVC.activity = activity![currentTableView][indexPath.row]
            self.navigationController?.pushViewController(destVC, animated: true)
        }else if currentTableView == 1{
            //Send data informasi ke VC Segmented 2
        }else{
            //Send data informasi ke VC Segmented 3
        }
    }
    
    private func cellDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "progressCell")
    }
    
    
}
extension SegmentedViewController {
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
        
        
        detailActivity1?.append(dataTab2Pertama)
        detailActivity1?.append(dataTab2Kedua)
        detailActivity1?.append(dataTab2Ketiga)
        detailActivity1 = [dataTab2Pertama,dataTab2Kedua,dataTab3Ketiga]
        
        detailActivity2?.append(dataTab3Pertama)
        detailActivity2?.append(dataTab3Kedua)
        detailActivity2?.append(dataTab3Ketiga)
        detailActivity2 = [dataTab3Pertama,dataTab3Kedua,dataTab3Ketiga]
        
        
        activity = [[],detailActivity1!,detailActivity2!]
    }

}
