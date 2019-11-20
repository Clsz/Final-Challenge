//
//  Model.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import Foundation

class Courses{
    var courseID, courseName, courseAddress, courseWorkQualification,  courseLocation, courseImage:String!
    var courseMinFare, courseMaxFare:Int!
    var courseWorkSchedule, courseCategory, courseWorkTime, courseGrade:[String]
    //    var courseCreatedAt:String
    //    var teacherQty:Int
    
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

struct Course {
    var courseID, courseName, courseAddress, courseLocation, courseImage:String!
    var courseMinFare, courseMaxFare:Int!
    var courseWorkSchedule, courseCategory, courseWorkQualification, courseGrade:[String]!
}



