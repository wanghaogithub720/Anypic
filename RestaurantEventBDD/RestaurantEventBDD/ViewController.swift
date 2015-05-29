//
//  ViewController.swift
//  RestaurantEventBDD
//
//  Created by djzhang on 5/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        saveTemp()
        
        saveRestaurant()
    }
    
    func saveRestaurant(){
        let image1 = UIImage(named: "recipe01.jpg")
        let image2 = UIImage(named: "recipe02.jpg")
        let image3 = UIImage(named: "recipe03.jpg")
        let image4 = UIImage(named: "recipe04.jpg")
        var images:[UIImage] = [image1!,image2!,image3!,image4!]
        
        SaveRestaurantUtils.saveRestaurant(images)
    }
    
    func saveTemp(){
        var object = PFObject(className: "temp")
        object["user"] = PFUser.currentUser()
        object["message"] = "chat message"
        
        object.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                let x = 0
            } else {
                let y = 0
            }
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

