//
//  Extension.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 28/10/19.
//  Copyright © 2019 12. All rights reserved.

import UIKit
import CloudKit

extension UIImageView{
    
    func setRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    func setRoundedBorder() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 1
        self.clipsToBounds = true
    }
}

extension UIView{
    
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1
    }
    
    func setBorder() {
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setBorderBlue() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.4, blue: 0.6862745098, alpha: 1)
    }
    
    func outerRound() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func outerRound2() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    func outerRound3() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension UIButton{
    
    func loginRound() {
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    func pickerButton() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Int{
    func toNumberFormat()->String{
        let myNumber = NSNumber(value:self)
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: myNumber) ?? "\(self)"
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    func toBirthString()->String{
          let formatter = DateFormatter()
          formatter.dateFormat = "dd MMMM yyyy"
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

    func toYear()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
    
}

extension CKRecord.ID {
    public static func fromUntrusted(_ string: String?) -> CKRecord.ID? {
        guard let string = string else { return nil }
        guard let _ = string.data(using: .ascii, allowLossyConversion: false) else { return nil }
        guard string.count > 0 && string.count < 255 else { return nil }
        return CKRecord.ID(recordName: string)
    }
}

extension CKAsset {
    func toUIImage() -> UIImage? {
        if let data = NSData(contentsOf: self.fileURL!) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}
