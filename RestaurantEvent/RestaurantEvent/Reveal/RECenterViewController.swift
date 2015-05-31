//
//  RECenterViewController.swift
//  RestaurantEvent
//
//  Created by djzhang on 5/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class RECenterViewController: UIViewController {
    
    let tabBarViewController: RETabBarViewController = RETabBarViewController.instance()
    lazy var tabBarInfos:[TabBarInfo] =  { return RETabBarGenerator.generateTabBarInfos()}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Center Panel"
        
        //self.tabBarViewControlle
        self.addChildViewController(self.tabBarViewController)
        self.view.addSubview(self.tabBarViewController.view)
        
        self.tabBarViewController.view.layoutPanelBottomMargin(50)
        self.tabBarViewController.layoutViewController(tabBarInfos)
        
        // current presentationView
        //        self.selectViewController(, button: <#UIButton#>)
    }
    
    func selectViewController(viewController:ViewController,button:UIButton){
        
    }
}