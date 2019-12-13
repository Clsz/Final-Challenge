//
//  JobInformationViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 05/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class JobInformationViewController: BaseViewController {
    
    @IBOutlet weak var maxSlider: UISlider!
    @IBOutlet weak var minSalaryLabel: UILabel!
    @IBOutlet weak var maxSalaryLabel: UILabel!
    @IBOutlet weak var qualificationTF: UITextField!
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var salaryMin:Double!
    //Value Min
    //Value Max
    var day:[String] = []
    var startHour:[String] = []
    var endHour:[String] = []
    lazy var jobDetailVC = JobDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Job Information")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func minSalarySlider(_ sender: UISlider) {
        let minSalary = Int((roundf(sender.value)*50000))
        let myMinSalary = minSalary.formattedWithSeparator
        
        let maxSalary = Int((roundf(sender.value)*50000))
        let myMaxSalary = maxSalary.formattedWithSeparator
        
        minSalaryLabel.text = "Rp \(myMinSalary)"
        
        maxSalaryLabel.text = "Rp \(myMaxSalary)"
        salaryMin = Double(sender.value)
    }
    
    @IBAction func maxSalarySlider(_ sender: UISlider) {
        maxSlider.minimumValue = Float(Double(salaryMin ?? 0))
        let maxSalary = Int((roundf(sender.value)*50000))
        let myMaxSalary = maxSalary.formattedWithSeparator
        maxSalaryLabel.text = "Rp \(myMaxSalary)"
    }
    
    @IBAction func addNewScheduleTapped(_ sender: Any) {
        let destVC = TeachingSchedulesViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    @IBAction func applyJobInformationTapped(_ sender: Any) {
        jobDetailVC.startHour = self.startHour
        jobDetailVC.endHour = self.endHour
        jobDetailVC.day = self.day
        //Min
        //Max
        jobDetailVC.qualification = self.qualificationTF.text
        self.navigationController?.pushViewController(jobDetailVC, animated: true)
    }
    
}

extension JobInformationViewController: UITextFieldDelegate {
    
    
    func setTextField() {
        qualificationTF.delegate = self
        
        qualificationTF.textAlignment = .left
        qualificationTF.contentVerticalAlignment = .top
        
        //Toolbar
        self.accessoryDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        qualificationTF.inputAccessoryView = accessoryToolBar
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    class CustomTextField: UITextField {
        
        let padding = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0);
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }
    
    
    @objc func donePressed(_ textField: UITextField) {
        moveTextField(textField, moveDistance: 0, up: true)
        view.endEditing(true)
    }
    
}
