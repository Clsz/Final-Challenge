//
//  Tab2ViewController.swift
//  Final Challenge
//
//  Created by Steven Gunawan on 03/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit

class Tab2ViewController: BaseViewController {
    
    @IBOutlet weak var segmentBimbel: UISegmentedControl!
    @IBOutlet weak var activityTV: UITableView!
    let database = CKContainer.init(identifier: "iCloud.Final-Challenge").publicCloudDatabase
    var activity:[[CKRecord]]?
    var detailActivity1 = [[CKRecord]:[CKRecord]]() // tab1
    var detailActivity2 = [[CKRecord]:[CKRecord]]() // tab2
    var detailActivity3 = [[CKRecord]:[CKRecord]]() // tab3
    var tempActivity:[CKRecord]?
    var tempCourse:[CKRecord]?
    var currentTableView:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableView = 0
        setColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView(text: "Activites")
        activityTV.reloadData()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    @IBAction func segmentSwitch(_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        activityTV.reloadData()
    }
}

extension Tab2ViewController {
    private func setColor() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentBimbel.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        let title = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentBimbel.setTitleTextAttributes(title, for: .normal)
        
        
        segmentBimbel.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentBimbel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        segmentBimbel.selectedSegmentTintColor = #colorLiteral(red: 0.1098039216, green: 0.3921568627, blue: 0.6666666667, alpha: 1)
    }
    
    private func queryActivity() {
        let query = CKQuery(recordType: "Activity", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.tempActivity = sortedRecords
            DispatchQueue.main.async {
                for i in self.tempActivity!{
                    self.queryCourse(i.value(forKey: "courseID") as! CKRecord.ID, completion: { (res) in
                        self.tempCourse?.append(res)
                    })
                }
            }
        }
    }
    
    func queryCourse(_ tempID:CKRecord.ID, completion: @escaping (CKRecord) -> Void) {
        
        let pred = NSPredicate(format: "recordName = %@", tempID.recordName)
        let query = CKQuery(recordType: "Course", predicate: pred)
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error as Any)
                return
            }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            completion( sortedRecords[0])
        }
        
    }
    
}
