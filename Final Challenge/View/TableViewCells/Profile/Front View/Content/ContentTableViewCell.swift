//
//  ContentTableViewCell.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var tutorDelegate:ProfileProtocol?
    var bimbelDelegate:BimbelProtocol?
    var index:Int?
    var skills:[String]?
    let filterCell = "filterCell"
    let skillCell = "SubjectCollectionViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if index == 0{
            
        }else{
            bimbelDelegate?.subjectTapped()
        }
    }
    
}
extension ContentTableViewCell{
    func setCell(title:String,button:String) {
        self.titleLabel.text = title
        self.editButton.setTitle(button, for: .normal)
        
        setInterface()
    }
    
    private func setInterface() {
        self.collectionView.outerRound()
    }
}
extension ContentTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func registerCell() {
        collectionView.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubjectCollectionViewCellID")
        collectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
    }
    
    private func cellDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if index == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: skillCell, for: indexPath) as! SubjectCollectionViewCell
            
            cell.setView(subject: skills?[indexPath.row] ?? "")
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
            cell.imageFilter.image = #imageLiteral(resourceName: "networking")
            cell.labelFilter.text = "Menangis"
            return cell
        }
    }
    
}
