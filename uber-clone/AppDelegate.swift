//
//  AppDelegate.swift
//  uber-clone
//
//  Created by Michael Luo on 24/4/19.
//  Copyright © 2019 Michael Luo. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    fileprivate var containerVC = OverlayViewController()

    var MenuContainerVC: OverlayViewController {
        return containerVC
    }

    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        //        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    private func setupLogger() {
        let consoleDestination = ConsoleDestination()
        consoleDestination.minLevel = .warning

//        let filter = PathFilterFactory.endsWith("UnfilteredViewController.m")
//        consoleDestination.addFilter(filter);

        log.addDestination(consoleDestination)
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        containerVC = OverlayViewController()
        window?.rootViewController = containerVC
        window?.makeKeyAndVisible()

        setupKeyboard()
        setupLogger()

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

    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
