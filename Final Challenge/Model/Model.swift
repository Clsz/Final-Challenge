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

struct Courses {
    var courseID, courseName, courseAddress, courseLocation, courseImage:String!
    var courseMinFare, courseMaxFare:Int!
    var courseWorkSchedule, courseCategory, courseWorkQualification, courseGrade:[String]!
}


var bimbel1: Courses = Courses(courseID: "01", courseName: "Next Level Bimbel", courseAddress: "BSD Anggrek Loka Jalan Anggrek Ungu Blok A No 1A Sektor 2-1 Serpong, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15310", courseLocation: "Kota Tangerang Selatan", courseImage: "", courseMinFare: 2000000, courseMaxFare: 3000000, courseWorkSchedule: ["09.00 A.M - 08.00 PM", "01.00 PM - 04.00 PM"], courseCategory: ["Matematika", "IPA", "IPS"], courseWorkQualification: ["Pendidikan minimal SMA/sederajat", "Lebih disukai yang memiliki pengalaman mengajar sebelumnya", "Jujur, pekerja keras, rajin dan tanggung jawab", "Komitmen mengajar selama minimal 6 bulan", "Memiliki kesabaran terhadap anak-anak"], courseGrade: ["SD"])

var bimbel2: Courses = Courses(courseID: "02", courseName: "Smart Mandarin Bimbel", courseAddress: "Ruko Crystal 1, No. 76 Jl. Boulevard Gading Serpong, Serpong Utara, Tangerang", courseLocation: "Kota Tangerang Selatan", courseImage: "", courseMinFare: 2500000, courseMaxFare: 3500000, courseWorkSchedule: ["10.00 A.M - 07.00 PM"], courseCategory: ["Mandarin"], courseWorkQualification: ["Minimal bisa membaca, menulis dan mendengar mandarin SD","Lebih disukai yang memiliki pengalaman mengajar mandarin sebelumnya", "Lebih disukai yang menyukai anak-anak", "Memiliki kesabaran yang tinggi", "Rajin, jujur dan tanggung jawab"], courseGrade: ["SD", "SMP"])

var bimbel3: Courses = Courses(courseID: "03", courseName: "B Smart Bimbel", courseAddress: "Bedugul 1A No 6, RT008/019, Perumahan Daan Mogot Baru, RT.8/RW.12, Kalideres, West Jakarta City, Jakarta 11840", courseLocation: "Jakarta Barat", courseImage: "", courseMinFare: 1800000, courseMaxFare: 3000000, courseWorkSchedule: ["04.00 P.M - 08.00 PM"], courseCategory: ["Matematika", "Fisika", "Kimia"], courseWorkQualification: ["Minimal harus dapat bekerja 2-3x seminggu pada jam 16.00-19.00","Memiliki minat untuk mengajar yang tinggi", "Memiliki kemauan untuk belajar materi yang diberikan di saat pelatihan", "Tanggung jawab dan komitmen", "Jujur dan rajin", "SMA jurusan IPA"], courseGrade: ["SMP", "SMA"])

var bimbel4: Courses = Courses(courseID: "04", courseName: "Bimbel Salembra Group(SG)", courseAddress: "Ruko Tol Boulevard Blok D Nomor 3 Jalan Pahlawan Seribu, Rw. Buntu, Kec. Serpong, Kota Tangerang Selatan, Banten 15417", courseLocation: "Kota Tangerang Selatan", courseImage: "", courseMinFare: 1500000, courseMaxFare: 2500000, courseWorkSchedule: ["Senin, 02.00 P.M - 06.00 PM", "Rabu, 03.00 P.M - 07.00"], courseCategory: ["Matematika", "Fisika", "Kimia", "IPS", "IPA"], courseWorkQualification: ["Berintegritas", "Disiplin", "Professional", "Mencintai dunia pendidikan"], courseGrade: ["SD", "SMP", "SMA"])

var bimbel5: Courses = Courses(courseID: "05", courseName: "Yayasan Pendidikan Avicenna Prestasi", courseAddress: "Jl. Ampera Raya No.18 - 20, RT.3/RW.6, Cilandak Tim., Jakarta, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12560", courseLocation: "Jakarta Selatan", courseImage: "", courseMinFare: 4000000, courseMaxFare: 5000000, courseWorkSchedule: ["Senin, 07.00 A.M - 12.00 PM", "Selasa, 07.00 A.M - 12.00 PM"], courseCategory: ["Matematika", "Bahasa Inggris"], courseWorkQualification: ["Pria/Wanita, usia maksimal 25 tahun", "Mampu berbahasa Inggris (lisan dan tulisan)", "Memiliki motivasi mengajar, kemauan belajar dan meningkatkan diri", "Memiliki kepribadian yang menarik, energik, komunikatif, dan kreatif", "Mempunyai komitmen yang tinggi dan teamwork yang baik", "Menguasai Microsoft Office dan program komputer lain yang relevan"], courseGrade: ["PAUD", "TK"])

var bimbel6: Courses = Courses(courseID: "06", courseName: "Level One Bimbel", courseAddress: "Jl. Bangun Nusa Raya No.9, RT.9/RW.2, Cengkareng Tim., Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730", courseLocation: "Jakarta Barat", courseImage: "", courseMinFare: 2000000, courseMaxFare: 4000000, courseWorkSchedule: ["Senin, 07.00 A.M - 12.00 PM", "Selasa, 07.00 A.M - 12.00 PM"], courseCategory: ["Matematika"], courseWorkQualification: ["Pendidikan minimal SMA/sederajat", "Lebih disukai yang memiliki pengalaman mengajar sebelumnya", "Jujur, pekerja keras, rajin dan tanggung jawab", "Komitmen mengajar selama minimal 6 bulan", "Memiliki kesabaran terhadap anak-anak"], courseGrade: ["SMP"])

var bimbel7: Courses = Courses(courseID: "07", courseName: "One Two Bimbel", courseAddress: "Rusun Cengkareng, Blok Seruni 6 Lt. Dasar, Jl. Kamal Raya, RT.14/RW.10, Cengkareng Barat, Cengkareng, RT.10/RW.10, Cengkareng Tim., Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730", courseLocation: "Jakarta Barat", courseImage: "", courseMinFare: 2000000, courseMaxFare: 3500000, courseWorkSchedule: ["Senin, 02.00 P.M - 06.00 PM", "Rabu, 03.00 P.M - 07.00 PM"], courseCategory: ["IPA"], courseWorkQualification: ["Lebih disukai yang memiliki pengalaman mengajar sebelumnya", "Jujur, pekerja keras, rajin dan tanggung jawab", "Komitmen mengajar selama minimal 1 tahun", "Memiliki kesabaran terhadap anak-anak"], courseGrade: ["SD"])

var bimbel8: Courses = Courses(courseID: "08", courseName: "Bimbel Rubah", courseAddress: "Jl. Rorotan No.8, RT.8/RW.3, Rorotan, Kec. Cilincing, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14140", courseLocation: "Jakarta Utara", courseImage: "", courseMinFare: 1000000, courseMaxFare: 2500000, courseWorkSchedule: ["Senin, 09.30 A.M - 13.00 PM", "Selasa, 01.00 PM - 04.00 PM", "Rabu, 01.00 PM - 04.00 PM"], courseCategory: ["Matematika"], courseWorkQualification: ["Lebih disukai yang memiliki pengalaman mengajar sebelumnya", "Jujur, pekerja keras, rajin dan tanggung jawab", "Komitmen mengajar selama minimal 1 tahun"], courseGrade: ["SMP"])

var bimbel9: Courses = Courses(courseID: "09", courseName: "Yayasan Pendidikan Bina Bangsa", courseAddress: "Kirana rorotan legacy cluster Norfolk 15, nomer No.31, RT.16/RW.5, Rorotan, Kec. Cilincing, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14140", courseLocation: "Jakarta Utara", courseImage: "", courseMinFare: 4000000, courseMaxFare: 4500000, courseWorkSchedule: ["Senin - Jumat, 07.00 A.M - 12.00 PM"], courseCategory: ["Bahasa Inggris"], courseWorkQualification: ["Pria/Wanita, usia maksimal 25 tahun", "Mampu berbahasa Inggris (lisan dan tulisan)", "Memiliki motivasi mengajar, kemauan belajar dan meningkatkan diri", "Memiliki kepribadian yang menarik, energik, komunikatif, dan kreatif", "Mempunyai komitmen yang tinggi dan teamwork yang baik", "Menguasai Microsoft Office dan program komputer lain yang relevan"], courseGrade: ["PAUD", "TK"])

var bimbel10: Courses = Courses(courseID: "10", courseName: "Yayasan Pendidikan Bina Air", courseAddress: "Blok H, Jl. Gading Arcadia, RT.5/RW.3, Pegangsaan Dua, Kec. Klp. Gading, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14250", courseLocation: "Jakarta Utara", courseImage: "", courseMinFare: 3000000, courseMaxFare: 4500000, courseWorkSchedule: ["Senin - Jumat, 07.00 A.M - 12.00 PM"], courseCategory: ["Bahasa Inggris"], courseWorkQualification: ["Pria/Wanita, usia maksimal 25 tahun", "Mampu berbahasa Inggris (lisan dan tulisan)", "Memiliki motivasi mengajar, kemauan belajar dan meningkatkan diri", "Memiliki kepribadian yang menarik, energik, komunikatif, dan kreatif", "Mempunyai komitmen yang tinggi dan teamwork yang baik", "Menguasai Microsoft Office dan program komputer lain yang relevan"], courseGrade: ["SD"])


let bimbel = [bimbel1, bimbel2, bimbel3, bimbel4, bimbel5, bimbel5, bimbel6, bimbel7, bimbel8, bimbel9, bimbel10]
