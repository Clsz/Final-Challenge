//
//  TabBarBimbelController.swift 
//  Final Challenge
//
//  Created by Steven Gunawan on 26/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class TabBarBimbelController: UITabBarController {
    
    var homeNav:UINavigationController!
    var homeVC: JobViewController!
    var detailNav:UINavigationController!
    var detailVC: SegmentedBimbelViewController!
    var profileNav:UINavigationController!
    var profileVC: BimbelProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        homeVC = JobViewController()
        homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Job", image: UIImage(named: "icon_job"), selectedImage: UIImage(named: "icon_job"))
        
        detailVC = SegmentedBimbelViewController()
        detailNav = UINavigationController(rootViewController: detailVC)
        detailNav.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(named: "tab_progres"), selectedImage: UIImage(named: "tab_progres"))
        
        profileVC = BimbelProfileViewController()
        profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "icon_profile"), selectedImage: UIImage(named: "icon_profile"))

        let tabBarList:[UIViewController] = [homeNav,detailNav,profileNav]

        viewControllers = tabBarList
    }
}
