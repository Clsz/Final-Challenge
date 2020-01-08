//
//  AppDelegate.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 28/10/19.
//  Copyright © 2019 12. All rights reserved.
//Unable to load contents of file list: '/Target Support Files/Pods-Final Challenge/Pods-Final Challenge-frameworks-Debug-input-files.xcfilelist'
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabBarController:TabBarController?
    var flag:Bool = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UserDefaults.standard.set("nextlevel@gmail.com", forKey: "tokenBimbel")
        UserDefaults.standard.set("noveliarefinda@gmail.com", forKey: "token")
        
        UITabBar.appearance().tintColor = ConstantManager.mainColor
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
//        let rv = TabBarBimbelController()
//        let navigationController = UINavigationController(rootViewController: rv)
        
        
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
        
        registerForPushNotifications()
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print(token)
        CKUserData.shared.saveDeviceToken(status: token)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
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
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        completionHandler([.alert, .sound])
    }
    
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    
    
}
