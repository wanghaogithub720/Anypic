//
//  RestaurantListViewController.swift
//  RestaurantEventBDD
//
//  Created by djzhang on 5/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class RestaurantListViewController: PFQueryTableViewController {
    
    class func instance() -> RestaurantListViewController {
        return UIStoryboard(name: "RestaurantEvent", bundle: nil).instantiateViewControllerWithIdentifier("RestaurantListViewController") as! RestaurantListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Restaurant List"
        
        // The className to query on
        self.parseClassName = kPAPPhotoClassKey
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = true
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = true
        
        // The number of objects to show per page
        // self.objectsPerPage = 10;
        
        // Improve scrolling performance by reusing UITableView section headers
        //        self.reusableSectionHeaderViews = [NSMutableSet setWithCapacity:3];
        
        // The Loading text clashes with the dark Anypic design
        self.loadingViewEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: PFQueryTableViewController
    override func queryForTable() -> PFQuery{
        return ParseQueryUtils.queryRestaurant()
    }
    
    //MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.objects!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pfObjects:[PFObject] = self.objects as! [PFObject]
        
        let photos:[PFObject] =   pfObjects[section].valueForKey(kPAPRestaurantPhotosKey) as! [PFObject]
        
        //Count is header + map + photos(array)
        return 1 + 1 + photos.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let identify = RestaurantTableUtils.getTableCellIdentify(indexPath.row)
        var cell:ParseAbstractTableCell = self.tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as! ParseAbstractTableCell
        
        configureCell(cell, forRowAtIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let width = self.view.bounds.size.width
        return RestaurantTableUtils.getTableCellHeight(indexPath.row, width:width)
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath?) -> PFObject? {
        var section:Int = indexPath!.section
        var row:Int = indexPath!.row
        let pfObject:[PFObject] = self.objects as! [PFObject]
        
        var object = pfObject[section]
        
        switch (row){
        case RestaurantTableRowType.UserInfo.hashValue:
            object = PFUser.currentUser()!
            break;
        case RestaurantTableRowType.RecipeLocation.hashValue:
            break;
        default:
            var photos:[PFObject]  = object.valueForKey(kPAPRestaurantPhotosKey) as! [PFObject]
            object = photos[row - 2]
            break;
        }
        
        return object
    }
    
    func configureCell(cell: ParseAbstractTableCell, forRowAtIndexPath: NSIndexPath) {
        let object: PFObject = self.objectAtIndexPath(forRowAtIndexPath)!
        cell.setCell(object)
    }
    
    
}
