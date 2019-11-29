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

protocol PasswordProtocol{
    func changePassword()
}

protocol ProfileDetailProtocol{
    func applyProfile()
}

protocol LanguageProtocol {
    func dropLanguage()
}

protocol EducationProtocol {
    func dropEducation()
}

protocol ExperienceProtocol {
    func startTapped()
    func endTapped()
    func dropExperience()
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

protocol SendTutorToCustom {
    func sendTutor(tutor:Tutor)
}

protocol refreshTableProtocol {
    func refreshTableView()
}
