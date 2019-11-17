//
//  SubjectCategoryTableViewCell.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 15/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SubjectCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subjectCV: UICollectionView!
    var course:Course!
     var dataArray:[Any?] = []
    
    func setView(title:String) {
        self.titleLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension SubjectCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjekCell", for: indexPath) as! SubjectCollectionViewCell
                   if let course = dataArray[indexPath.row] as? Course {
                    cell.labelSubjek.text = course.courseCategory[indexPath.row]
                   }
                   return cell
    }
    
    func cellDelegate() {
        subjectCV.delegate = self
        subjectCV.dataSource = self
    }
    
    
}
