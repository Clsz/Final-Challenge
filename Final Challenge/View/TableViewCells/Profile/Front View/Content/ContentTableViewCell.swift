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
    var contentDelegate:ProfileProtocol?
    
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
        contentDelegate?.skillTapped()
    }
    
}
extension ContentTableViewCell{
    func setCell(title:String,button:String) {
        self.titleLabel.text = title
        self.editButton.setTitle(button, for: .normal)
    }
    
    private func setInterface() {
        self.collectionView.outerRound()
    }
}
extension ContentTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func registerCell() {
        collectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: filterCell)
    }
    
    private func cellDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutor.tutorSkills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as! FilterCollectionViewCell
        cell.labelFilter.text = tutor.tutorSkills[indexPath.row]
        return cell
    }
    
}
