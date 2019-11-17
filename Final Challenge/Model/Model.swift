//
//  Model.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import Foundation

class Course{
    var courseID:String
    var courseName, courseAddress, courseImage:String
    var courseMinFare:[String]
    var courseMaxFare:[String]
    var courseWorkSchedule, courseCategory, courseWorkQualification, courseGrade:[String]
//    var courseCreatedAt:String
//    var teacherQty:Int
    
    init(_ courseID:String, _ courseName:String, _  courseAddress:String, _ courseImage:String, _ courseMinFare:[String], _ courseCategory:[String], _ courseGrade:[String], _ courseMaxFare:[String], _ courseWorkSchedule:[String], _ courseWorkQualification:[String]) {
        self.courseID = courseID
        self.courseName = courseName
        self.courseAddress = courseAddress
        self.courseImage = courseImage
        self.courseMinFare = courseMinFare
        self.courseMaxFare = courseMaxFare
        self.courseWorkSchedule = courseWorkSchedule
        self.courseWorkQualification = courseWorkQualification
        self.courseCategory = courseCategory
        self.courseGrade = courseGrade
    }
}

struct Activity{
    var activityID:String
    var courseID:String
    var activityStatus:String
}

class Tutor{
    var tutorID:String
    var educationID:String
    var email:String
    var password:String
    var tutorFirstName, tutorLastName, tutorImage, tutorPhoneNumber, tutorAddress, tutorGender:String
    var tutorBirthDate:String
    var tutorSkills, tutorExperience, tutorLanguage, tutorAchievement:[String]
    
    init(_ tutorID:String, _ educationID:String, _ email:String, _ password:String, _ tutorFirstName:String, _ tutorLastName:String, _ tutorImage:String, _ tutorPhoneNumber:String, _ tutorAddress:String, _ tutorGender:String, _ tutorBirthDate:String, _ tutorSkills:[String], _ tutorExperience:[String], _ tutorLanguage:[String], _ tutorAchievement:[String]) {
        self.tutorID = tutorID
        self.educationID = educationID
        self.email = email
        self.password = password
        self.tutorFirstName = tutorFirstName
        self.tutorLastName = tutorLastName
        self.tutorImage = tutorImage
        self.tutorPhoneNumber = tutorPhoneNumber
        self.tutorAddress = tutorAddress
        self.tutorGender = tutorGender
        self.tutorBirthDate = tutorBirthDate
        self.tutorSkills = tutorSkills
        self.tutorExperience = tutorExperience
        self.tutorLanguage = tutorLanguage
        self.tutorAchievement = tutorAchievement
    }
}


struct Education{
    var educationID:String
    var universityName, fieldOfStudy, grade:String
    var startYear:String
    var endYear:String
}
