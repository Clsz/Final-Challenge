//
//  SkillsViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 10/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SkillsViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var hardSkillsCV: UICollectionView!
    @IBOutlet weak var softSkillsCV: UICollectionView!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Skill")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Skill")
    }

}
