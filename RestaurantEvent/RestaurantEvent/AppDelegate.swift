//
//  AppDelegate.swift
//  RestaurantEvent
//
//  Created by djzhang on 5/27/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,PAWLoginViewControllerDelegate {
    
    var window: UIWindow?
    lazy var navigationController:UINavigationController = {
        return  UINavigationController(rootViewController:  UIViewController())
        }()
    
    let viewController:JASidePanelController = JASidePanelController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // ****************************************************************************
        // Parse initialization
        ParseCrashReporting.enable()
        Parse.setApplicationId("cFOCgoE6v77JoeGXkF5cK5az4FLM5twfdOCGBphU", clientKey: "eJ5fVdx0SO8cXrZ8mTxxwREK34wpZ6VMcHBumKZl")
        
        PFFacebookUtils.initializeFacebook()
        // ****************************************************************************
        
        // Track app open.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        if (application.applicationIconBadgeNumber != 0) {
            application.applicationIconBadgeNumber = 0;
            PFInstallation.currentInstallation().saveInBackground()
        }
        
        let defaultACL = PFACL();
        
        // If you would like all objects to be private by default, remove this line.
        defaultACL.setPublicReadAccess(true)
        
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
        
         self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if ((PFUser.currentUser()) != nil) {
            // Present wall straight-away
            self.presentWallViewControllerAnimated(false)
        } else {
            // Go to the welcome screen and have them log in or create an account.
            self.presentLoginViewController()
            self.window?.rootViewController = self.navigationController
        }
        self.window?.makeKeyAndVisible()
        
        // test
//        let xxx:RETabBarViewController = RETabBarViewController.instance()
        
        return true
    }
    
    func presentTabBarController(){

    }
    
    
    // MARK: WallViewController
    func presentWallViewControllerAnimated(animated: Bool){
        self.viewController.shouldDelegateAutorotateToVisiblePanel = false
        
        self.viewController.leftPanel = RELeftViewController()
        
        let viewController: RECenterViewController =  RECenterViewController()
        self.viewController.centerPanel = UINavigationController(rootViewController: viewController)
        
        self.window?.rootViewController = self.viewController
    }
    
    // MARK: PAWLoginViewControllerDelegate
    func loginViewControllerDidLogin(controller: PAWLoginViewController!) {
        self.presentWallViewControllerAnimated(true)
    }
    
    // MARK: LoginViewController
    func presentLoginViewController() {
        // Go to the welcome screen and have them log in or create an account.
        let viewController: PAWLoginViewController =  PAWLoginViewController(nibName: nil, bundle: nil)
        viewController.delegate = self
        self.navigationController.setViewControllers([viewController], animated: false)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, withSession:PFFacebookUtils.session())
    }
    
    
}

