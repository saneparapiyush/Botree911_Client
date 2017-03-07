//
//  FragmentViewController.swift
//  Botree911_Client
//
//  Created by piyushMac on 09/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import FTProgressIndicator
import Alamofire
import SwiftyJSON

class FragmentViewController: AbstractViewController,CarbonTabSwipeNavigationDelegate {

    var items = [String]()
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var selectedIndex = Int()
    
    var allTickets: JSON! = nil
    var ticketListSource = [Ticket]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = getLocalizedString("title_ticket_list")
        
        //For Add navigation bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddOnClick))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carbonTabSwipeNavigation.removeFromParentViewController()
        getTicketList()
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        let vc = AppRouter.sharedRouter().getViewController("TicketListViewController") as! TicketListViewController
        
        ticketListSource = [Ticket]()
        
        var statusKey = ""
        
        switch index {
        case 0:
            
            statusKey = "to_do"
            
            break
        case 1:
            
            statusKey = "in_progress"
            
            break
        
        case 2:
            
            statusKey = "resolved"
            
            break
        
        case 3:
            
            statusKey = "close"
            
            break
            
        case 4:
            
            statusKey = "unassigned"
            
            break
            
        default:
            break
        }
        
        for i in 0 ..< allTickets[statusKey].count {
            let jsonValue = allTickets[statusKey].arrayValue[i]
            let ticketDetail = Ticket(json: jsonValue)
            ticketListSource.append(ticketDetail)
        }
        
        vc.ticketListSource = ticketListSource
        
        return vc
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt)
    {
        NSLog("Did move at index: %ld", index)
        
        /*switch index {
        case 0:
            carbonTabSwipeNavigation.setIndicatorColor(UIColor(red: 255/255, green: 16/255, blue: 8/255, alpha: 1))
            carbonTabSwipeNavigation.setSelectedColor(UIColor(red: 255/255, green: 16/255, blue: 8/255, alpha: 1), font: UIFont.boldSystemFont(ofSize: 14))

        case 1:
            carbonTabSwipeNavigation.setIndicatorColor(UIColor(red: 255/255, green: 119/255, blue: 50/255, alpha: 1))
            carbonTabSwipeNavigation.setSelectedColor(UIColor(red: 255/255, green: 119/255, blue: 50/255, alpha: 1), font: UIFont.boldSystemFont(ofSize: 14))

        case 2:
            carbonTabSwipeNavigation.setIndicatorColor(UIColor(red: 0/255, green: 72/255, blue: 226/255, alpha: 1))
            carbonTabSwipeNavigation.setSelectedColor(UIColor(red: 0/255, green: 72/255, blue: 226/255, alpha: 1), font: UIFont.boldSystemFont(ofSize: 14))

        case 3:
            carbonTabSwipeNavigation.setIndicatorColor(themeColor)
            carbonTabSwipeNavigation.setSelectedColor(themeColor, font: UIFont.boldSystemFont(ofSize: 14))

        default:
            print(index)
        }*/
    }
    
    func setUpFragmentMenu() {
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.currentTabIndex = UInt(selectedIndex)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        
//        for (index, _) in items.enumerated() {
//            carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(self.view.frame.width / 2.5, forSegmentAt: index)
//        }
    }
    
    func style()
    {
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.setIndicatorColor(themeColor)
        carbonTabSwipeNavigation.setSelectedColor(themeColor, font: UIFont.boldSystemFont(ofSize: 14))
        
        carbonTabSwipeNavigation.setTabExtraWidth(15)
        
        carbonTabSwipeNavigation.setNormalColor(UIColor.black.withAlphaComponent(0.6))
    }
    
    //    MARK:- Actions
    func btnAddOnClick() {
//        selectedTicket = nil
        self.performSegue(withIdentifier: "showAddTicket", sender: self)
    }// end btnAddOnClick()
    
    //    MARK:- Helper Method
    
    func getTicketList() {
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("ticket_list_indicator"), userInteractionEnable: false)
        do {
            try Alamofire.request(ComunicateService.Router.TicketList().asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Ticket List Response: \(json)")
                        self.dismissIndicator()
                        
                        if (json.dictionaryObject!["status"] as? Bool)! && json["data"]["tickets"].count > 0 {
                            self.processGetResponceTicketList(json: json["data"])
                        } else {
                            //                            print((json.dictionaryObject!["message"])!)
//                            self.view.makeToast("\((json.dictionaryObject!["message"])!)")
                            self.configToast(message: "\((json.dictionaryObject!["message"])!)")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.dismissIndicator()
                    self.configToast(message: error.localizedDescription)
                }
            }
        } catch let error{
            print(error)
            self.dismissIndicator()
            self.configToast(message: error.localizedDescription)
        }
    } // End getTicketList()
    
    func processGetResponceTicketList(json: JSON) {
        
        allTickets = json["tickets"]
        items.removeAll()
//        items = ["To do","In Progress","Resolved","Close","Unassigned"]
        
        items.append("To do (\(allTickets["to_do"].count))")
        items.append("Resolved (\(allTickets["resolved"].count))")
        items.append("In Progress (\(allTickets["in_progress"].count))")
        items.append("Close (\(allTickets["close"].count))")
        items.append("Unassigned (\(allTickets["unassigned"].count))")
        
//        for (key, value) in allTickets {
//            items.append(key + " (\(value.count))")
//        }
        
        setUpFragmentMenu()
        style()
        
      /*  for i in 0 ..< projects.count {
            let jsonValue = projects.arrayValue[i]
            let ticketDetail = Ticket(json: jsonValue)
            ticketListSource.append(ticketDetail)
        }*/
//        tblTicketList.reloadData()
    }// End procssGetResponceProjectList
}
