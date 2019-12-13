//
//  Protocol.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileProtocol{
    func pencilTapped()
    func skillTapped()
    func languageTapped()
    func educationTapped()
    func experienceTapped()
    func achievementTapped()
    func logout()
}

protocol BimbelProtocol{
    func pencilTapped()
    func addressTapped()
    func subjectTapped()
    func gradesTapped()
    func logout()
}

protocol SendLocation {
    func sendIndex(arrIndex:[Int])
}

protocol PasswordProtocol{
    func changePassword()
}

protocol ProfileDetailProtocol{
    func applyProfile()
}

protocol PhotoProtocol {
    func photoTapped()
}

protocol ProfileBimbelDetailProtocol {
    func imageTapped()
    func startTapped()
    func endTapped()
    func applyProfileBimbel()
}

protocol LanguageProtocol {
    func dropLanguage()
    func dropProfiency()
}

protocol EducationProtocol {
    func startTapped()
    func endTapped()
    func dropEducation()
}

protocol ExperienceProtocol {
    func startTapped()
    func endTapped()
    func dropExperience()
}

protocol BirthProtocol {
    func dropBirth()
}

protocol HomeProtocol {
    func bimbelTapped()
}

protocol DetailBimbel{
    func requestTapped()
}

protocol ActivityProcess {
    func accept()
    func reject()
}

protocol ActivityProtocol {
    func requestNewSchedule()
}

protocol ShowMoreLanguage{
    func showLanguage()
}

protocol ShowMoreExperience{
    func showExperience()
}

protocol LanguageViewControllerDelegate: class {
    func refreshData(withTutorModel: Tutor)
}

protocol SendTutorToCustom {
    func sendTutor(tutor:Tutor)
}

protocol refreshTableProtocol {
    func refreshTableView()
}

protocol JobDetail {
    func seeDetailTapped()
}

protocol SendFilter{
    func sendDataFilter(location:[String], minSalary:Double, maxSalary:Double, grade:[String], subject:[String])
}

protocol GetSelectedContent {
    func getIndex(arrayIndex:[Int])
}

protocol UpdateConstraint {
    func updateViewConstraint()
}

protocol PassSubjectToDetails{
    func passDataToSubject(arrSubject:[String])
}

