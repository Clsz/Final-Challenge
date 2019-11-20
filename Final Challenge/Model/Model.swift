//
//  Model.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import Foundation

var tutor = Tutor("01", [], "unknown@gmail.com", "rahasia", "", "", "", "", "", "", "", [], [], [], [])
var education:Education?
var language:Language?
var experience:Experience?

class Courses{
    
    var courseID, courseName, courseAddress, courseWorkQualification,  courseLocation, courseImage:String!
    var courseMinFare, courseMaxFare:Int!
    var courseWorkSchedule, courseCategory, courseWorkTime, courseGrade:[String]!
    
    init(_ courseID:String, _ courseName:String, _  courseAddress:String,_ courseLocation:String, _ courseImage:String, _ courseMinFare:Int, _ courseMaxFare:Int,  _ courseWorkSchedule:[String], _ courseWorkTime:[String], _ courseCategory:[String], _ courseWorkQualification:String, _ courseGrade:[String]) {
        self.courseID = courseID
        self.courseName = courseName
        self.courseAddress = courseAddress
        self.courseLocation = courseLocation
        self.courseImage = courseImage
        self.courseMinFare = courseMinFare
        self.courseMaxFare = courseMaxFare
        self.courseWorkSchedule = courseWorkSchedule
        self.courseWorkTime = courseWorkTime
        self.courseWorkQualification = courseWorkQualification
        self.courseCategory = courseCategory
        self.courseGrade = courseGrade
    }
}

class Activity{
    var activityID:String
    var activityStatus:String
    var interviewSchedule, interviewTime:[String]
    var testEquipment:String
    var courseID, courseName, courseAddress, courseWorkQualification,  courseLocation, courseImage:String!
    var courseMinFare, courseMaxFare:Int!
    var courseWorkSchedule, courseCategory, courseWorkTime, courseGrade:[String]!
    
    init(_ activityID:String, _ activityStatus:String, _ interviewSchedule:[String], _ interviewTime:[String], _ testEquipment:String, _ courseID:String, _ courseName:String, _  courseAddress:String,_ courseLocation:String, _ courseImage:String, _ courseMinFare:Int, _ courseMaxFare:Int,  _ courseWorkSchedule:[String], _ courseWorkTime:[String], _ courseCategory:[String], _ courseWorkQualification:String, _ courseGrade:[String]) {
        self.activityID = activityID
        self.activityStatus = activityStatus
        self.interviewSchedule = interviewSchedule
        self.interviewTime = interviewTime
        self.testEquipment = testEquipment
        self.courseID = courseID
        self.courseName = courseName
        self.courseAddress = courseAddress
        self.courseLocation = courseLocation
        self.courseImage = courseImage
        self.courseMinFare = courseMinFare
        self.courseMaxFare = courseMaxFare
        self.courseWorkSchedule = courseWorkSchedule
        self.courseWorkTime = courseWorkTime
        self.courseWorkQualification = courseWorkQualification
        self.courseCategory = courseCategory
        self.courseGrade = courseGrade
    }
    
}

class Tutor{
    var tutorID:String
    var tutorEducation:[Education]
    var email:String
    var password:String
    var tutorFirstName, tutorLastName, tutorImage, tutorPhoneNumber, tutorAddress, tutorGender:String
    var tutorBirthDate:String
    var tutorSkills:[String]
    var tutorExperience:[Experience]
    var tutorLanguage:[Language]
    var tutorAchievement:[Any]
    
    init(_ tutorID:String, _ tutorEducation:[Education], _ email:String, _ password:String, _ tutorFirstName:String, _ tutorLastName:String, _ tutorImage:String, _ tutorPhoneNumber:String, _ tutorAddress:String, _ tutorGender:String, _ tutorBirthDate:String, _ tutorSkills:[String], _ tutorExperience:[Experience], _ tutorLanguage:[Language], _ tutorAchievement:[Any]) {
        self.tutorID = tutorID
        self.tutorEducation = tutorEducation
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

class Education{
    var educationID:String
    var universityName, educationLevel, fieldOfStudy, grade:String
    var startYear:String
    var endYear:String
    
    init(_ educationID:String, _ universityName:String, _ educationLevel:String, _ fieldOfStudy:String, _ grade:String, _ startYear:String, _ endYear:String) {
        self.educationID = educationID
        self.universityName = universityName
        self.educationLevel = educationLevel
        self.fieldOfStudy = fieldOfStudy
        self.grade = grade
        self.startYear = startYear
        self.endYear = endYear
    }
}

class Language{
    var languageName:String
    var languageProficiency:String
    
    init(_ languageName:String, _ languageProficiency:String) {
        self.languageName = languageName
        self.languageProficiency = languageProficiency
    }
}

class Experience{
    var title, experienceType, company, location, startDate, endDate:String
    
    init(_ title:String, _ experienceType:String, _ company:String, _ location:String, _ startDate:String, _ endDate:String) {
        self.title = title
        self.experienceType = experienceType
        self.company = company
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
    }
}




