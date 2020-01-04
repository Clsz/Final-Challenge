//
//  AppDelegate.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 28/10/19.
//  Copyright © 2019 12. All rights reserved.
//Unable to load contents of file list: '/Target Support Files/Pods-Final Challenge/Pods-Final Challenge-frameworks-Debug-input-files.xcfilelist'
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController:TabBarController?
    var flag:Bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //        let rv = HomeViewController()
        //        let navigationController = UINavigationController(rootViewController: rv)

        UITabBar.appearance().tintColor = ConstantManager.mainColor
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if CKUserData.shared.getOnBoardingStatus() != "" {
            //Flag di set False ketika dia mau Apply tetapi belum login
            //Selama dia true seperti flag yang sudah di inisialisasi di atas gak bakal di suruh login
            //Kalau mau batasin hak akses contoh seperti DetailBimbelViewController (func requestTapped)
            if flag == false{
                let rootVC = LoginViewController()
                let navigationController = UINavigationController(rootViewController: rootVC)
                window?.rootViewController = navigationController
                window?.makeKeyAndVisible()
            }
            let rootVC = ChooseRoleViewController()
            let navigationController = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = rootVC
            window?.makeKeyAndVisible()
        }else{
            let vc = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: vc)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

