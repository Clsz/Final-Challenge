//
//  SetupSkillsViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 17/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SetupSkillsViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewSoftSkills: UICollectionView!
    @IBOutlet weak var collectionViewHardSkills: UICollectionView!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainInterface()
        setupView(text: "Skill Setup")
    }

    @IBAction func applyTapped(_ sender: Any) {
        
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        
    }

}
extension SetupSkillsViewController{
    private func setMainInterface() {
        self.applyButton.loginRound()
    }
}
