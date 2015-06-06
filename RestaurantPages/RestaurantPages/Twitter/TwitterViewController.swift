//
//  TwitterViewController.swift
//  RestaurantPages
//
//  Created by djzhang on 6/5/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    @IBOutlet weak var infoContainer: UIView!
    
    @IBOutlet weak var infoContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var meViewController:MeViewController = {return MeViewController.instance()}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addChildViewController(meViewController)
        self.infoContainer.addSubview(meViewController.view)
        meViewController.view.LayoutFullView()
        
        // tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cells", forIndexPath: indexPath) as! UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let width = tableView.frame.size.width
        return width/507*290
    }
    
    
    // MARK: Sticky User Header view on the top of the screen
    
    func scrollViewDidScroll(scrollView: UIScrollView) { // used
        positionCells(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        positionCells(scrollView)
    }
    
    
    func positionCells(scrollView: UIScrollView) {
        
        let scrollOffset = scrollView.contentOffset.y
        println("\(scrollOffset)")
        
        //        println("++++++++++++++++++++")
        //        if let cells = self.tableView!.visibleCells() as? [ParseAbstractTableCell]{
        //            for cell in cells {
        //                println("\(cell)")
        //
        //                let cellOffset = cell.frame.origin.y
        //                let headerOffset = scrollOffset - cellOffset
        //                if headerOffset >= 0 {
        //                    //                cell.headerTop?.constant = headerOffset
        //                } else {
        //                    //                cell.headerTop?.constant = 0
        //                }
        //            }
        //        }
        
    }
    
    
}
