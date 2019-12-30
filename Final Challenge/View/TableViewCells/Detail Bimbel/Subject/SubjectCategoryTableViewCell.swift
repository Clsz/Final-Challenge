//
//  SubjectCategoryTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SubjectCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var subjekCV: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    let contentSubject = "SubjectCollectionViewCellID"
    var subject:[String] = []
    
    func setView(title:String) {
        self.titleLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        cellDelegate()
        subjekCV.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension SubjectCategoryTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subjekCV.dequeueReusableCell(withReuseIdentifier: contentSubject, for: indexPath) as! SubjectCollectionViewCell
        cell.setView(subject: subject[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185, height: 44)
    }
    
    private func cellDelegate() {
        subjekCV.dataSource = self
        subjekCV.delegate = self
    }
    
    private func registerCell() {
        subjekCV.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentSubject)
    }
    
}
