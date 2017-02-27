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
import Toast

class TicketListViewController: AbstractViewController {
    
    var project : Project?
    var ticketListSource = [Ticket]()
    var selectedTicket : Ticket?
    
    @IBOutlet var tblTicketList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }// End viewDidLoad()
    
    override func viewDidAppear(_ animated: Bool) {

        //            MARK: OFLINE
//                getTicketList()
//        setOflineDataSource()
        //            MARK: END OFLINE
        
    }// End viewDidAppear()
    
//    MARK:- Actions
    
    var selectedIndexForHistoryComment = 0
    func btnHistoryOnClick(sender: UIButton){
        //        let buttonTag = sender.tag
        selectedTicket = ticketListSource[sender.tag]
        selectedIndexForHistoryComment = 1
        self.performSegue(withIdentifier: "showTicketInfo", sender: self)
    } //End btnHistoryOnClick()
    func btnCommentOnClick(sender: UIButton){
        //        let buttonTag = sender.tag
        
        selectedTicket = ticketListSource[sender.tag]
        selectedIndexForHistoryComment = 2
        self.performSegue(withIdentifier: "showTicketInfo", sender: self)
    } //End btnCommentOnClick()
    
    //    MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTicketInfo" {
            let fragmentControll = segue.destination as! FragmentTicketDetailViewController
            fragmentControll.title = getLocalizedString("title_edit_ticket")
            fragmentControll.project = project
            fragmentControll.ticket = selectedTicket
            fragmentControll.selectedIndex = selectedIndexForHistoryComment
            
            /*let destinationVC = tabCtrl.viewControllers![0] as! AddTicketViewController
            destinationVC.project = project
            destinationVC.ticket = selectedTicket
            
            let historyVC = tabCtrl.viewControllers![1] as! HistoryViewController
            historyVC.ticket = selectedTicket
            
            let commentVC = tabCtrl.viewControllers![2] as! CommentViewController
            commentVC.ticket = selectedTicket*/
            
        } /*else if segue.identifier == "showAddTicket" {
            let addTicketVC = segue.destination as! AddTicketViewController
            addTicketVC.project = project!
            addTicketVC.ticket = selectedTicket
//          addTicketVC.title = getLocalizedString("title_add_ticket")
        }*/
        
    }
}

extension TicketListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketListSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTicketList.dequeueReusableCell(withIdentifier: "TicketListCell") as! TicketListCell
        
        cell.btnHistory.tag = indexPath.row
        cell.btnHistory.addTarget(self, action: #selector(btnHistoryOnClick), for: .touchUpInside)
        
        cell.btnComment.tag = indexPath.row
        cell.btnComment.addTarget(self, action: #selector(btnCommentOnClick), for: .touchUpInside)
        
        cell.ticket = ticketListSource[indexPath.row]
        
        cell.configView()
        cell.setTicketListData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTicket = ticketListSource[indexPath.row]
        selectedIndexForHistoryComment = 0
        self.performSegue(withIdentifier: "showTicketInfo", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == ticketListSource.count - 1 {
            return 134.0
        }
        return 126.0
    }
}

class TicketListCell: UITableViewCell {
    var ticket: Ticket?
    
    @IBOutlet var viewMain: UIView!
    
    @IBOutlet var lblTicketTitle: UILabel!
    @IBOutlet var lblTicketDescription: UILabel!
    @IBOutlet var lblDate: ThemeLabelDetail!
    
    @IBOutlet var lblAssingee: UILabel!
    
    @IBOutlet var btnComment: UIButton!
    @IBOutlet var btnHistory: UIButton!

    
    func setTicketListData() {
        lblTicketTitle.text = ticket?.name
        lblTicketDescription.text = ticket?.description
        lblDate.text = ticket?.created_at?.dateFormatting()
        
        lblAssingee.text = ticket?.assingee
        btnComment.setTitle("\(ticket!.comment_count!)", for: .normal)
        btnHistory.setTitle("\(ticket!.history_count!)", for: .normal)
    }
    
    func configView() {
        viewMain.layer.cornerRadius = 5.0
        viewMain.layer.borderWidth = 1.0
        viewMain.layer.borderColor = themeTextBorderColor.cgColor
        
        btnComment.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
        btnHistory.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    }
}

/*
extension TicketListViewController {
    
    func setOflineDataSource() {
        
        let params = [
            "status": true,
            "message": "Ticket list",
            "data": [
                "ticket": [
                    [
                    "id": 1,
                    "project_id": 2,
                    "name": "Change Login Screen",
                    "description": "add Facebook Integration in Login",
                    "status": "Pending",
                    "updated_at": "Jan 21, 2017",
                    "raised_by": "Olivia Wilde",
                    "assingee": "Bhavin Nattar"
                    ],
                    [
                    "id": 2,
                    "project_id": 3,
                    "name": "UI Theme",
                    "description": "change Mobile Theme",
                    "status": "Pending",
                    "updated_at": "Jan 1, 2017",
                    "raised_by": "Scarlett Johansson",
                    "assingee": "Piyush Sanepara"
                    ]
                ]
            ]
        ] as Any
        
        let json = JSON(params)
        self.processGetResponceTicketList(json: json["data"])
    }
}
*/
