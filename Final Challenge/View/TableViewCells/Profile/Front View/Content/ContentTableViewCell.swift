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
    let filterCell = "filterCell"
    var tutorDelegate:ProfileProtocol?
    var bimbelDelegate:BimbelProtocol?
    var index:Int?
    var tutorCustom:Tutor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if index == 0{
            tutorDelegate?.skillTapped()
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
extension ContentTableViewCell:SendTutorToCustom{
    func sendTutor(tutor: Tutor) {
        self.tutorCustom = tutor
    }
}
extension ContentTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate{
    private func registerCell() {
        collectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
    }
    
    private func cellDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
        cell.imageFilter.image = #imageLiteral(resourceName: "networking")
        cell.labelFilter.text = "Menangis"
        return cell
    }
    
}
