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
    var detailNav:UINavigationController!
    var detailVC: SegmentedViewController!
    var profileNav:UINavigationController!
    var profileVC: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        homeVC = HomeViewController()
        homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icon_job"), selectedImage: UIImage(named: "icon_job"))
        
        detailVC = SegmentedViewController()
        detailNav = UINavigationController(rootViewController: detailVC)
        detailNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icon_activity"), selectedImage: UIImage(named: "icon_activity"))
        
        profileVC = ProfileViewController()
        profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icon_profile"), selectedImage: UIImage(named: "icon_profile"))

        let tabBarList:[UIViewController] = [homeNav,detailNav,profileNav]

        viewControllers = tabBarList
    }
}


