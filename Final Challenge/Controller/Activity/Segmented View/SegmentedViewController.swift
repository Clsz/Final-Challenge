//
//  SegmentedViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SegmentedViewController: BaseViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var activity:[[Activity]]?
    var detailActivity1:[Activity] = []
    var detailActivity2:[Activity]?
    var detailActivity3:[Activity]?
    var currentTableView:Int!
    var define:Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableView = 0
        initializeData()
        registerCell()
        cellDelegate()
        setColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Progres")
        tableView.reloadData()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    func setColor() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        let title = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentView.setTitleTextAttributes(title, for: .normal)
        
     
        segmentView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        segmentView.selectedSegmentTintColor = #colorLiteral(red: 0.3254901961, green: 0.7803921569, blue: 0.9411764706, alpha: 1)
    }
    
}



extension SegmentedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity![currentTableView].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.selectionStyle = .none
        cell.setView(nama: activity![currentTableView][indexPath.row].courseName, status: activity![currentTableView][indexPath.row].activityStatus)
        
        if activity![currentTableView][indexPath.row].activityStatus == "TES DIBATALKAN"{
            cell.statusBimbel.textColor = .red
        }else if activity![currentTableView][indexPath.row].activityStatus == "MENUNGGU HASIL TES"{
            cell.statusBimbel.textColor = .darkGray
        }else if activity![currentTableView][indexPath.row].activityStatus == "MEMINTA JADWAL TES BARU"{
            cell.statusBimbel.textColor = .orange
        }else if activity![currentTableView][indexPath.row].activityStatus == "DITERIMA"{
            cell.statusBimbel.textColor = .green
        }else{
            cell.statusBimbel.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentTableView == 0{
            //Send data informasi ke VC Segmented 1
            let destVC = DetailBimbelTabFirstViewController()
            destVC.activity = activity![currentTableView][indexPath.row]
            self.navigationController?.pushViewController(destVC, animated: true)
        }else if currentTableView == 1{
            let destVC = DetailTestViewController()
            destVC.activity = activity![currentTableView][indexPath.row]
            self.navigationController?.pushViewController(destVC, animated: true)
        }else{
            if activity![currentTableView][indexPath.row].activityStatus == "DITERIMA"{
                let destVC = WaitingConformationViewController()
                destVC.activity = activity![currentTableView][indexPath.row]
                self.navigationController?.pushViewController(destVC, animated: true)
            }else{
                let destVC = DetailFinalThirdViewController()
                destVC.activity = activity![currentTableView][indexPath.row]
                self.navigationController?.pushViewController(destVC, animated: true)
            }
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
        let dataTab2Pertama: Activity = Activity("01", "TES DIBATALKAN", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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
        
        let dataTab2Kedua: Activity = Activity("02", "MENUNGGU HASIL TES", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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
        
        let dataTab2Ketiga: Activity = Activity("03", "MEMINTA JADWAL TES BARU", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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
        
        let dataTab3Pertama: Activity = Activity("01", "DITERIMA", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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
        
        let dataTab3Kedua: Activity = Activity("02", "DITERIMA", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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
        
        let dataTab3Ketiga: Activity = Activity("03", "DITOLAK", ["10.00 A.M - 12.00 AM", "11.20 A.M - 13.20 PM", "09.00 A.M - 11.00 PM"], ["Rabu, 27 Desember 2019", "Kamis, 28 Desember 2019", "Jumat, 29 Desember 2019"],
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
        
        
        detailActivity2?.append(dataTab2Pertama)
        detailActivity2?.append(dataTab2Kedua)
        detailActivity2?.append(dataTab2Ketiga)
        detailActivity2 = [dataTab2Pertama,dataTab2Kedua,dataTab2Ketiga]
        
        detailActivity3?.append(dataTab3Pertama)
        detailActivity3?.append(dataTab3Kedua)
        detailActivity3?.append(dataTab3Ketiga)
        detailActivity3 = [dataTab3Pertama,dataTab3Kedua,dataTab3Ketiga]
        
        
        activity = [detailActivity1 ?? [],detailActivity2 ?? [],detailActivity3 ?? []]
    }
    
}
