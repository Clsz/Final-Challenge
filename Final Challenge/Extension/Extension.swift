//
//  Extension.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 28/10/19.
//  Copyright © 2019 12. All rights reserved.

import UIKit

extension UIView {

    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1
    }
}


extension String{
    
    func isValidEmail() -> Bool {
        let emailFormat =
        "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword()->Bool{
        //Minimum of 6 characters (1 uppercase, 1 lowercase and 1 number)
        let passwordFormat = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
    
    func toDate()->Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: self)
    }
    
    func toProfileDate()->Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }

    func toNumberFormat()->String{
        if let myInteger = Int(self) {
            let myNumber = NSNumber(value:myInteger)
            let formater = NumberFormatter()
            formater.groupingSeparator = "."
            formater.numberStyle = .decimal
            return formater.string(from: myNumber) ?? self
        }
        return self
    }
    
    func htmlToAttributed()->NSAttributedString{
        let data = Data(self.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        }
        return NSAttributedString()
    }
}

extension Date{
    func toFullString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"
        return formatter.string(from: self)
    }
    
    func toString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func toProfileString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    func toTitle()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
    
    func toDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    func toMonth()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
}
