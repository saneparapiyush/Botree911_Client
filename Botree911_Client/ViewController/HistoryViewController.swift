//
//  HistoryViewController.swift
//  Botree911_Client
//
//  Created by piyushMac on 08/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import Alamofire
import FTProgressIndicator
import SwiftyJSON
import Toast

class HistoryViewController: AbstractViewController {

    @IBOutlet var tblHistoryList: UITableView!
    
    var ticket: Ticket?
    var historyListSource = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    } // End viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        //            MARK: OFLINE
        //        getHistoryList()
        setOflineDataSource()
        //            MARK: END OFLINE

    }//End viewWillAppear()
    
    
//    MARK:- Helper Method
    func getHistoryList() {
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("history_list_indicator"), userInteractionEnable: false)
        do {
            try Alamofire.request(ComunicateService.Router.HistoryList((ticket!.id)!).asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("History List Response: \(json)")
                        
                        if (json.dictionaryObject!["status"] as? Bool)! && json["data"]["history"].count > 0 {
                            self.processGetResponceHistoryList(json: json["data"])
                        } else {
                            self.view.makeToast("\((json.dictionaryObject!["message"])!)")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.dismissIndicator()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.dismissIndicator()
                    self.view.makeToast(error.localizedDescription)
                }
            }
        } catch let error{
            print(error)
            self.dismissIndicator()
            self.view.makeToast(error.localizedDescription)
        }
    } // End getCommentList()
    
    func processGetResponceHistoryList(json: JSON) {
        historyListSource = [History]()
        let history = json["history"]
        
        for i in 0 ..< history.count {
            let jsonValue = history.arrayValue[i]
            let historyDetail = History(json: jsonValue)
            historyListSource.append(historyDetail)
        }
        tblHistoryList.reloadData()
    }// End processGetResponceCommentList
}

extension HistoryViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyListSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblHistoryList.dequeueReusableCell(withIdentifier: "HistoryListCell") as! HistoryListCell
        
        cell.history = historyListSource[indexPath.row]
        cell.setHistoryListData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == historyListSource.count - 1 {
//            return 81.0
//        }
//        return 73.0
//    }
}

class HistoryListCell: UITableViewCell {
    var history: History?
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblLastStatus: UILabel!
//    @IBOutlet var lblCurrentStatus: UILabel!
    @IBOutlet var lblHistoryDateTime: UILabel!
    
    func setHistoryListData() {
        
        lblUserName.text = history?.user_name
        lblLastStatus.text = history?.last_status
//        lblCurrentStatus.text = history?.current_status
        lblHistoryDateTime.text = history?.date_time
    }
}

extension HistoryViewController {
    
    func setOflineDataSource() {
        
        let params = [
            "status": true,
            "message": "Ticket status history",
            "data": [
                "history": [
                    [
                        "id": 4,
                        "user_name": "Tm1 ",
                        "last_status": "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        "current_status": "to_do",
                        "date_time": "2017-02-07T09:51:54.781Z"
                    ],
                    [
                        "id": 5,
                        "user_name": "Tm2 ",
                        "last_status": "In Progress",
                        "current_status": "Resolved",
                        "date_time": "2017-02-07T09:52:41.038Z"
                    ],
                    [
                        "id": 6,
                        "user_name": "Client ",
                        "last_status": "Resolved",
                        "current_status": "Close",
                        "date_time": "2017-02-07T09:53:32.143Z"
                    ]
                ]
            ]
            ] as Any
        
        let json = JSON(params)
        self.processGetResponceHistoryList(json: json["data"])
    }
}
