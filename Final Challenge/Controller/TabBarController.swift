//
//  TabBarController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 09/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var homeNav:UINavigationController!
    var homeVC: HomeViewController!
    var profileNav:UINavigationController!
    var profileVC: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        homeVC = HomeViewController()
        homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "networking"), selectedImage: UIImage(named: "networking"))
        
        profileVC = ProfileViewController()
        profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "reunion"), selectedImage: UIImage(named: "reunion"))

        let tabBarList:[UIViewController] = [homeNav,profileNav]

        viewControllers = tabBarList
    }
}
