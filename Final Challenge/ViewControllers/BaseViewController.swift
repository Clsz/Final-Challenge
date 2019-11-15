//
//  BaseViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loading:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView(text:String) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.navigationItem.title = text
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String, completion: @escaping ()-> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading(){
        if loading == nil{
            loading = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();
            
            loading!.view.addSubview(loadingIndicator)
            present(loading!, animated: true, completion: nil)
        }
    }
    
    func hideLoading(completion: @escaping ()->Void){
        if loading != nil{
            loading!.dismiss(animated: true, completion: {
                self.loading = nil
                completion()
            })
        }
    }
    func hideLoading(){
        if loading != nil{
            loading!.dismiss(animated: true, completion: {
                self.loading = nil
            })
        }
    }
    
}

