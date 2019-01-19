//
//  AppDelegate.swift
//  AdFooter
//
//  Created by tnantoka on 11/27/2015.
//  Copyright (c) 2015 tnantoka. All rights reserved.
//

import UIKit
import AdFooter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().barTintColor = UIColor.gray
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let navController = storyboard.instantiateInitialViewController() as? UINavigationController {
            // https://firebase.google.com/docs/admob/ios/quick-start
            AdFooter.shared.adMobApplicationId = "ca-app-pub-3940256099942544~1458002511"

            // https://developers.google.com/admob/ios/banner
            AdFooter.shared.adMobAdUnitId = "ca-app-pub-3940256099942544/2934735716"

            // https://firebase.google.com/docs/admob/ios/interstitial
            AdFooter.shared.interstitial.adMobAdUnitId = "ca-app-pub-3940256099942544/4411468910"
            window?.rootViewController = AdFooter.shared.wrap(navController)
        }
    
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

