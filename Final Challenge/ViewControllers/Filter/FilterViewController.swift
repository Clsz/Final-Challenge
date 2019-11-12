//
//  FilterViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    
    var selectedRow = -1
    
    let images = UIImage(named: "tick")
    let images1 = UIImage(named: "Add")
    
    let lokasi = [
        "Alam Sutera",
        "BSD",
        "Gading Serpong",
        "Karawaci",
    ]
    
    let subjek = [
           "Matematika",
           "IPA",
           "Bahasa Inggris",
           "Bahasa Indonesia",
       ]
    
    let grade = [
           "Sekolah Dasar(SD)",
           "Sekolah Menengah Pertama(SMP)",
           "Sekolah Menengah Atas(SMA)"
       ]
    
    @IBOutlet weak var LocationCV: UICollectionView!
    @IBOutlet weak var subjectCV: UICollectionView!
    @IBOutlet weak var gradeCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegate()
        LocationCV.reloadData()
        self.LocationCV.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Filters")
    }
    
}

extension FilterViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lokasi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        
        cell.labelFilter.text = lokasi[indexPath.row]
        cell.kotakFilter.layer.borderColor = #colorLiteral(red: 0.2392156863, green: 0.431372549, blue: 0.8, alpha: 1)
            cell.kotakFilter.layer.borderWidth = 1
        cell.kotakFilter.layer.cornerRadius = 10
        
        if selectedRow == indexPath.row {
            cell.kotakFilter.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.7803921569, blue: 0.9411764706, alpha: 1)
            cell.kotakFilter.layer.borderWidth = 0
            cell.imageFilter.image = images
        }
        else {
            cell.layer.borderWidth = 0
            cell.kotakFilter.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.imageFilter.image = images1
            
            }
             return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let cellsAcross: CGFloat = 3
        //        let spaceBetweenCells: CGFloat = 5
        //        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        //        print(indexPath)
        return CGSize(width: 180, height: 44)
        
    }
    
    func cellDelegate() {
        LocationCV.delegate = self
        LocationCV.dataSource = self
        subjectCV.delegate = self
        subjectCV.dataSource = self
        gradeCV.delegate = self
        gradeCV.dataSource = self
    }
    
    func registerCell() {
        LocationCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        subjectCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        gradeCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedRow == indexPath.row {
            selectedRow = -1
        } else {
            selectedRow = indexPath.row
        }
        collectionView.reloadData()
    }
    
}
