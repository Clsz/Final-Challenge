//
//  HomeViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: BaseViewController{
    
    let images = UIImage(named: "school")
    var bimbel:[Courses] = []
    var homeDelegate:HomeProtocol?
    
    
    @IBOutlet weak var jobTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        registerCell()
        initializeData()
        jobTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Pekerjaan")
    }
    
    
    @IBAction func filterTapped(_ sender: UIButton) {
        let filterVC = FilterViewController()
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
}

extension HomeViewController{
    
    //    func set() {
    //        datas.removeAll()
    //        datas.append(bimbel1)
    //        datas.append(bimbel2)
    //        datas.append(bimbel3)
    //        datas.append(bimbel4)
    //        datas.append(bimbel5)
    //        datas.append(bimbel6)
    //        datas.append(bimbel7)
    //        datas.append(bimbel8)
    //        datas.append(bimbel9)
    //        datas.append(bimbel10)
    //    }
    
    func initializeData() {
        let bimbel1: Courses = Courses("01", "Next Level Bimbel", "BSD Anggrek Loka Jalan Anggrek Ungu Blok A No 1A Sektor 2-1 Serpong, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15310", "Kota Tangerang Selatan", "", 2000000, 3000000, ["09.00 A.M - 08.00 PM", "01.00 PM - 04.00 PM"], ["Everyday", "Everyday"], ["Matematika", "IPA", "IPS"],
            """
            - Pendidikan minimal SMA/sederajat
            - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
            - Jujur, pekerja keras, rajin dan tanggung jawab
            - Komitmen mengajar selama minimal 6 bulan
            - Memiliki kesabaran terhadap anak-anak
            """, ["SD"])
        
        let bimbel2: Courses = Courses("02", "Smart Mandarin Bimbel", "Ruko Crystal 1, No. 76 Jl. Boulevard Gading Serpong, Serpong Utara, Tangerang", "Kota Tangerang Selatan", "", 2500000, 3500000, ["10.00 A.M - 07.00 PM"], ["Everyday"], ["Mandarin"],
            """
            - Minimal bisa membaca, menulis dan mendengar mandarin SD
            - Lebih disukai yang memiliki pengalaman mengajar mandarin sebelumnya
            - Lebih disukai yang menyukai anak-anak
            - Memiliki kesabaran yang tinggi
            - Rajin, jujur dan tanggung jawab
            """, ["SD", "SMP"])
        
        let bimbel3: Courses = Courses("03", "B Smart Bimbel", "Bedugul 1A No 6, RT008/019, Perumahan Daan Mogot Baru, RT.8/RW.12, Kalideres, West Jakarta City, Jakarta 11840", "Jakarta Barat", "", 1800000, 3000000, ["04.00 P.M - 08.00 PM"], ["Everyday"], ["Matematika", "Fisika", "Kimia"],
            """
            - Minimal harus dapat bekerja 2-3x seminggu pada jam 16.00-19.00
            - Memiliki minat untuk mengajar yang tinggi
            - Memiliki kemauan untuk belajar materi yang diberikan di saat pelatihan
            - Tanggung jawab dan komitmen
            - Jujur dan rajin
            - SMA jurusan IPA
            """, ["SMP", "SMA"])
        
        let bimbel4: Courses = Courses("04", "Bimbel Salembra Group(SG)", "Ruko Tol Boulevard Blok D Nomor 3 Jalan Pahlawan Seribu, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15417", "Kota Tangerang Selatan", "", 1500000, 2500000, ["02.00 P.M - 06.00 PM", "03.00 P.M - 07.00"], ["Senin", "Rabu"], ["Matematika", "Fisika", "Kimia", "IPS", "IPA"],
            """
            - Berintegritas
            - Disiplin
            - Professional
            - Mencintai dunia pendidikan
            """, ["SD", "SMP", "SMA"])
        
        let bimbel5: Courses = Courses("05", "Yayasan Pendidikan Avicenna Prestasi", "Jl. Ampera Raya No.18 - 20, RT.3/RW.6, Cilandak Tim., Jakarta, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12560", "Jakarta Selatan", "", 4000000, 5000000, ["07.00 A.M - 12.00 PM", "07.00 A.M - 12.00 PM"], ["Senin", "Selasa"], ["Matematika", "Bahasa Inggris"],
            """
            - Pria/Wanita, usia maksimal 25 tahun
            - Mampu berbahasa Inggris (lisan dan tulisan)
            - Memiliki motivasi mengajar, kemauan belajar dan meningkatkan diri
            - Memiliki kepribadian yang menarik, energik, komunikatif, dan kreatif
            - Mempunyai komitmen yang tinggi dan teamwork yang baik
            - Menguasai Microsoft Office dan program komputer lain yang relevan
            """, ["PAUD", "TK"])
        
        let bimbel6: Courses = Courses("06", "Level One Bimbel", "Jl. Bangun Nusa Raya No.9, RT.9/RW.2, Cengkareng Tim., Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730", "Jakarta Barat", "", 2000000, 4000000, ["07.00 A.M - 12.00 PM", "07.00 A.M - 12.00 PM"], ["Senin", "Selasa"], ["Matematika"],
            """
            - Pendidikan minimal SMA/sederajat
            - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
            - Jujur, pekerja keras, rajin dan tanggung jawab
            - Komitmen mengajar selama minimal 6 bulan
            - Memiliki kesabaran terhadap anak-anak
            """, ["SMP"])
        
        let bimbel7: Courses = Courses("07", "One Two Bimbel", "Rusun Cengkareng, Blok Seruni 6 Lt. Dasar, Jl. Kamal Raya, RT.14/RW.10, Cengkareng Barat, Cengkareng, RT.10/RW.10, Cengkareng Tim., Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730", "Jakarta Barat", "", 2000000, 3500000, ["02.00 P.M - 06.00 PM", "03.00 P.M - 07.00 PM"], ["Senin", "Rabu"], ["IPA"],
            """
            - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
            - Jujur, pekerja keras, rajin dan tanggung jawab
            - Komitmen mengajar selama minimal 1 tahun
            - Memiliki kesabaran terhadap anak-anak
            """, ["SD"])
        
        let bimbel8: Courses = Courses("08", "Bimbel Rubah", "Jl. Rorotan No.8, RT.8/RW.3, Rorotan, Kec. Cilincing, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14140", "Jakarta Utara", "", 1000000, 2500000, ["09.30 A.M - 13.00 PM", "01.00 PM - 04.00 PM", "01.00 PM - 04.00 PM"], ["Senin", "Selasa", "Rabu"], ["Matematika"],
            """
            - Lebih disukai yang memiliki pengalaman mengajar sebelumnya
            - Jujur, pekerja keras, rajin dan tanggung jawab
            - Komitmen mengajar selama minimal 1 tahun
            """, ["SMP"])
        
        let bimbel9: Courses = Courses("09", "Yayasan Pendidikan Bina Bangsa", "Kirana rorotan legacy cluster Norfolk 15, nomer No.31, RT.16/RW.5, Rorotan, Kec. Cilincing, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14140", "Jakarta Utara", "", 4000000, 4500000, ["07.00 A.M - 12.00 PM"], ["Senin - Jumat"], ["Bahasa Inggris"],
            """
            - Pria/Wanita, usia maksimal 25 tahun
            - Mampu berbahasa Inggris (lisan dan tulisan)
            - Memiliki motivasi mengajar, kemauan belajar dan meningkatkan diri
            - Memiliki kepribadian yang menarik, energik, komunikatif, dan kreatif
            - Mempunyai komitmen yang tinggi dan teamwork yang baik
            - Menguasai Microsoft Office dan program komputer lain yang relevan
            """, ["PAUD", "TK"])
        
        let bimbel10: Courses = Courses("10", "Yayasan Pendidikan Bina Air", "Blok H, Jl. Gading Arcadia, RT.5/RW.3, Pegangsaan Dua, Kec. Klp. Gading, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14250", "Jakarta Utara", "", 3000000, 4500000, ["07.00 A.M - 12.00 PM"], ["Senin - Jumat"], ["Bahasa Inggris"],
            """
            - Pria/Wanita, usia maksimal 25 tahun
            - Mampu berbahasa Inggris (lisan dan tulisan)
            - Memiliki motivasi mengajar, kemauan belajar dan meningkatkan diri
            - Memiliki kepribadian yang menarik, energik, komunikatif, dan kreatif
            - Mempunyai komitmen yang tinggi dan teamwork yang baik
            - Menguasai Microsoft Office dan program komputer lain yang relevan
            """, ["SD"])
        
        
        bimbel = [bimbel1, bimbel2, bimbel3, bimbel4, bimbel5, bimbel6, bimbel7, bimbel8, bimbel9, bimbel10]
    }
}

extension HomeViewController:HomeProtocol{
    func bimbelTapped() {
    }
    
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bimbel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! ListJobTableViewCell
        cell.bimbelView.layer.borderWidth = 3
        cell.bimbelView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        cell.bimbelView.layer.cornerRadius = 15
        cell.bimbelView.layer.masksToBounds = true
        cell.bimbelView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectionStyle = .none
        cell.bimbelPhoto.image = images
        
        let data = bimbel[indexPath.row]
        
        if let namaBimbel = data.courseName {
            cell.bimbelName.text = namaBimbel
        }
        
        if let lokasiBimbel = data.courseLocation{
            cell.bimbelLocation.text = lokasiBimbel
        }
        
        let gajiBimbel =  "Rp \(String(describing: data.courseMinFare!.formattedWithSeparator)) - Rp \(String(describing: data.courseMaxFare!.formattedWithSeparator))"
        cell.bimbelSubject.text = gajiBimbel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailBimbelViewController()
        print(bimbel[indexPath.row])
        destVC.course = bimbel[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func cellDelegate(){
        jobTableView.dataSource = self
        jobTableView.delegate = self
    }
    
    func registerCell() {
        jobTableView.register(UINib(nibName: "ListJobTableViewCell", bundle: nil), forCellReuseIdentifier: "jobCell")
    }
    
}




