//
//  AppDelegate.swift
//  RestaurantEventBDD
//
//  Created by djzhang on 5/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,PAWLoginViewControllerDelegate {
    
    var window: UIWindow?
    lazy var navigationController:UINavigationController = {
        return  UINavigationController(rootViewController:  UIViewController())
        }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // ****************************************************************************
        // Parse initialization
        ParseCrashReporting.enable()
        Parse.setApplicationId("cFOCgoE6v77JoeGXkF5cK5az4FLM5twfdOCGBphU", clientKey: "eJ5fVdx0SO8cXrZ8mTxxwREK34wpZ6VMcHBumKZl")
        
        //        PFFacebookUtils.initializeFacebook()
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
        
        // Set Navigation bar appearance
        UINavigationBar.appearance().barTintColor = UIColor.applicationNavBarColor()
        
        let navbarFont = UIFont(name: "Ubuntu", size: 17) ?? UIFont.systemFontOfSize(17)
        let barbuttonFont = UIFont(name: "Ubuntu-Light", size: 15) ?? UIFont.systemFontOfSize(15)
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if ((PFUser.currentUser()) != nil) {
            // Present wall straight-away
            //            self.presentRestaurantListViewController(false)
            //            self.presentiewController()
            //            ParseQueryUtils.queryRestaurant()
            self.navigationController.setViewControllers([RECenterViewController.instance()], animated: false)
        } else {
            // Go to the welcome screen and have them log in or create an account.

            self.presentLoginViewController()
            
        }
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func presentiewController(){
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let viewController: UIViewController = ViewController.instance()
        self.navigationController.setViewControllers([viewController], animated: false)
        self.window?.rootViewController = self.navigationController
        
        self.window?.makeKeyAndVisible()
        
        self.window?.backgroundColor = UIColor.blueColor()
    }
    
    // MARK: RestaurantListViewController
    func presentRestaurantListViewController(animated: Bool){
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //        let viewController: UIViewController = RestaurantListViewController.instance()
        let viewController: UIViewController = RestaurantCollectionViewController.instance()
        self.navigationController.setViewControllers([viewController], animated: false)
        self.window?.rootViewController = self.navigationController
        
        self.window?.makeKeyAndVisible()
        
        self.window?.backgroundColor = UIColor.redColor()
    }
    
    // MARK: LoginViewController
    func presentLoginViewController() {
        // Go to the welcome screen and have them log in or create an account.
        let viewController: PAWLoginViewController =  PAWLoginViewController(nibName: nil, bundle: nil)
        viewController.delegate = self
        self.navigationController.setViewControllers([viewController], animated: false)
    }
    
    
    // MARK: PAWLoginViewControllerDelegate
    func loginViewControllerDidLogin(controller: PAWLoginViewController!) {
        self.presentRestaurantListViewController(false)
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
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

