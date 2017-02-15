//
//  FragmentTicketDetailViewController.swift
//  Botree911_Client
//
//  Created by piyushMac on 15/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit

class FragmentTicketDetailViewController: AbstractViewController,CarbonTabSwipeNavigationDelegate {
    
    var items = NSArray()
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = ["DETAIL", "HISTORY","COMMENTS"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        
        style()
        
        //        carbonTabSwipeNavigation.carbonSegmentedControl?.selectedSegmentIndex = 3
//        carbonTabSwipeNavigation.currentTabIndex = UInt(selectedIndex)
        
        title = getLocalizedString("title_ticket_list")
    }
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        switch index {
        case 0:
            return AppRouter.sharedRouter().getViewController("AddTicketViewController") as! AddTicketViewController
        case 1:
            return AppRouter.sharedRouter().getViewController("HistoryViewController") as! HistoryViewController
        
        case 2:
            return AppRouter.sharedRouter().getViewController("CommentViewController") as! CommentViewController
        default:
            return AppRouter.sharedRouter().getViewController("AddTicketViewController") as! AddTicketViewController
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt)
    {
        NSLog("Did move at index: %ld", index)
    }
    
    func style()
    {
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.setIndicatorColor(themeColor)
        carbonTabSwipeNavigation.setSelectedColor(themeColor, font: UIFont.boldSystemFont(ofSize: 14))
        
        carbonTabSwipeNavigation.setTabExtraWidth(30)
        
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 3.5, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 3.5, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 3.5, forSegmentAt: 2)
        
        
        carbonTabSwipeNavigation.setNormalColor(UIColor.black.withAlphaComponent(0.6))
    }
    
    //    MARK:- Actions
    func btnAddOnClick() {
        //        selectedTicket = nil
        self.performSegue(withIdentifier: "showAddTicket", sender: self)
    }// end btnAddOnClick()
}
