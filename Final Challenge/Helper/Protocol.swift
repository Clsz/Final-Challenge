//
//  Protocol.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 14/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import Foundation

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

protocol showMoreLanguage{
    func showLanguage()
}

protocol showMoreExperience{
    func showExperience()
}
