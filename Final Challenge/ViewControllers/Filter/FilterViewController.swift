//
//  FilterViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 12/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    let name = [
        "Alam Sutera",
        "BSD",
        "Gading Serpong",
        "Karawaci",
    ]
    
    @IBOutlet weak var LocationCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        cellDelegate()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FilterViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCollectionViewCell
        
        cell.labelFilter.text = name[indexPath.row]
        
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 5
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)
        
    }
    
    func cellDelegate() {
        LocationCV.delegate = self
        LocationCV.dataSource = self
    }
    
    func registerCell() {
        LocationCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        
    }
    
    
}
