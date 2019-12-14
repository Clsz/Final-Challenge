//
//  JobDetailsViewController.swift
//  Final Challenge
//
//  Created by Jason Valencius Wijaya on 05/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class JobDetailsViewController: BaseViewController {
    
    @IBOutlet weak var cvTeachingSubjects: UICollectionView!
    @IBOutlet weak var gradeTV: UITableView!
    @IBOutlet weak var scheduleTV: UITableView!
    @IBOutlet weak var salaryTF: UITextField!
    @IBOutlet weak var qualificationTF: UITextField!
    @IBOutlet weak var postJobButton: UIButton!
    var arraySubject:[String] = []
    var arrayGrade:[String] = []
    var minSalary:String?
    var maxSalary:String?
    var day:[String] = []
    var startHour:[String] = []
    var endHour:[String] = []
    var qualification:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cellDelegateCV()
        self.cvTeachingSubjects.reloadData()
//        cellDelegateTV()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Job Details")
        setMainInterface()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func editSubjectTapped(_ sender: Any) {
        
    }
    
    @IBAction func editGradesTapped(_ sender: Any) {
        
    }
    
    @IBAction func editSalaryTapped(_ sender: Any) {
        
    }
    @IBAction func editScheduleTapped(_ sender: Any) {
        
    }
    
    @IBAction func editQualificationTapped(_ sender: Any) {
        
    }
    
    @IBAction func postJobTapped(_ sender: Any) {
        
    }
    
}
extension JobDetailsViewController{
    private func setMainInterface() {
        self.postJobButton.loginRound()
    }
    
    private func registerCell() {
        cvTeachingSubjects.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubjectCollectionViewCellID")
        gradeTV.register(UINib(nibName: "TeachingGradePlainTableViewCell", bundle: nil), forCellReuseIdentifier: "TeachingGradePlainTableViewCellID")
        scheduleTV.register(UINib(nibName: "TeachingScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "TeachingScheduleTableViewCellID")
    }
    
}
extension JobDetailsViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private func cellDelegateCV() {
        self.cvTeachingSubjects.dataSource = self
        self.cvTeachingSubjects.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arraySubject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvTeachingSubjects.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCellID", for: indexPath) as! SubjectCollectionViewCell
        cell.setView(subject: arraySubject[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 44)
    }
    
}
//extension JobDetailsViewController:UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//    private func cellDelegateTV() {
//        self.gradeTV.dataSource = self
//        self.gradeTV.delegate = self
//        self.scheduleTV.dataSource = self
//        self.scheduleTV.delegate = self
//    }
//}
