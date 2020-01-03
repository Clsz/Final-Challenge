//
//  Slide.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 26/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class Slide: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var pushButton: UIButton!
    var listener: OnBoardingInputData?
 
    @IBAction func pushButtonAction(_ sender: UIButton) {
        listener?.didTap()
    }
}
