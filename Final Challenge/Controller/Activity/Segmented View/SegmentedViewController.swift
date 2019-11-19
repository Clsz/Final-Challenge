//
//  SegmentedViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 19/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class SegmentedViewController: BaseViewController {
    @IBOutlet weak var viewContainer: UIView!
    
    var viewTab: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewSegment()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Progres")
    }
    
    func setViewSegment() {
        viewTab = [UIView]()
        viewTab.append(FirstTabViewController().view)
        viewTab.append(SecondTabViewController().view)
        viewTab.append(ThirdTabViewController().view)
        
        for v in viewTab {
            viewContainer.addSubview(v)
        }
        viewContainer.bringSubviewToFront(viewTab[0])
    }
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(viewTab[sender.selectedSegmentIndex])
    }
    
}
