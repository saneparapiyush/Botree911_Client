//
//  TicketListViewController.swift
//  Botree911_Client
//
//  Created by piyushMac on 03/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import FTProgressIndicator

class TicketListViewController: AbstractViewController {
    
    var projectId : Int?
    var ticketListSource = [Ticket]()
    
    @IBOutlet var tblTicketList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //For Add navigation bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddOnClick))
        
        title = getLocalizedString("title_ticket_list")
        
        getTicketList()
    }// End viewDidLoad()
    
    func getTicketList() {
        
        let params: Parameters = [
            "project_id": projectId!
        ]
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("ticket_list_indicator"), userInteractionEnable: false)
        do {
            try Alamofire.request(ComunicateService.Router.TicketList(params).asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Ticket List Response: \(json)")
                        
                        if (json.dictionaryObject!["status"] as? Bool)! {
                            self.processGetResponceTicketList(json: json["data"])
                        } else {
                            print((json.dictionaryObject!["message"])!)
                        }
                    }
                    
                    self.dismissIndicator()
                case .failure(let error):
                    print(error)
                    self.dismissIndicator()
                }
            }
        } catch let err{
            print(err)
            self.dismissIndicator()
        }
    } // End getTicketList()
    
    func processGetResponceTicketList(json: JSON) {
        let projects = json["tickets"]
        
        for i in 0 ..< projects.count {
            let jsonValue = projects.arrayValue[i]
            let TicketDetail = Ticket(json: jsonValue)
            ticketListSource.append(TicketDetail)
        }
        tblTicketList.reloadData()
    }// End procssGetResponceProjectList
    
//    MARK:- Actions
    func btnAddOnClick() {
        self.performSegue(withIdentifier: "showAddTicket", sender: self)
    }// end btnAddOnClick()
    
    //    MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddTicket" {
            let addTicketVC = segue.destination as! AddTicketViewController
            addTicketVC.projectId = projectId!
        }
    }
}

extension TicketListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketListSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTicketList.dequeueReusableCell(withIdentifier: "TicketListCell") as! TicketListCell
        
        cell.ticket = ticketListSource[indexPath.row]
        cell.setProjectListData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == ticketListSource.count {
            return 108.0
        }
        return 100.0
    }
}

class TicketListCell: UITableViewCell {
    var ticket: Ticket?
    
    @IBOutlet var lblTicketTitle: UILabel!
    @IBOutlet var lblTicketDescription: UILabel!
    @IBOutlet var lblTicketStatus: UILabel!
    
    func setProjectListData() {
        
        lblTicketTitle.text = ticket?.name
        lblTicketDescription.text = ticket?.description
        lblTicketStatus.text = ticket?.status
    }
}
