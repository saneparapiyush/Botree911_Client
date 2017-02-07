//
//  ProjectListViewController.swift
//  Botree911_Client
//
//  Created by piyushMac on 02/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import FTProgressIndicator


class ProjectListViewController: AbstractViewController {
    
    var projectListSource = [Project]()
    
    var selectProjectIndexPath = IndexPath()
    
    @IBOutlet var tblProjectList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = getLocalizedString("title_project_list")
        showNavigationBar()
        // For Add SignOut Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(btnSignOutOnClick))
        
        getProjectList()
    }
    
    func getProjectList() {
        
        let serviceManager = ServiceManager()
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("project_list_indicator"), userInteractionEnable: false)
        
        serviceManager.getProjectList { (success, error, json) in
            if success {
                self.projectListSource = json!
                self.tblProjectList.reloadData()
            } else {
                print(error)
            }
            self.dismissIndicator()
        }
    } // End getProjectList()
    /*
    func processGetResponceProjectList(json: JSON) {
        let projects = json["projects"]
        
        for i in 0 ..< projects.count {
                let jsonValue = projects.arrayValue[i]
                let projectDetail = Project(json: jsonValue)
                projectListSource.append(projectDetail)
        }
        
        tblProjectList.reloadData()
    } // End procssGetResponceProjectList*/
    //Mark:- Actions
    func btnSignOutOnClick() {
        
    }//End btnSignOutOnClick()
    
//    MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTicketList" {
            let ticketListVC = segue.destination as! TicketListViewController
            ticketListVC.project = projectListSource[selectProjectIndexPath.row]
        }
    }
}

extension ProjectListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectListSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblProjectList.dequeueReusableCell(withIdentifier: "ProjectListCell") as! ProjectListCell
        
        cell.project = projectListSource[indexPath.row]
        cell.setProjectListData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ticketVC: TicketListViewController = AppRouter.sharedRouter().getViewController("TicketListViewController") as! TicketListViewController
//        
//        ticketVC.projectId = projectListSource[indexPath.row].id!
        selectProjectIndexPath = indexPath
        self.performSegue(withIdentifier: "showTicketList", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == projectListSource.count - 1 {
            return 108.0
        }
        return 100.0
    }
}

class ProjectListCell: UITableViewCell {
    var project: Project?
    
    @IBOutlet var lblProjectTitle: UILabel!
    @IBOutlet var lblProjectDescription: UILabel!
    @IBOutlet var lblTeamMember: UILabel!
    
    @IBOutlet var btnProjectInfo: UIButton!
    
    func setProjectListData() {
        
        btnProjectInfo.imageView?.contentMode = .center
        
        lblProjectTitle.text = project?.name
        lblProjectDescription.text = project?.description
        lblTeamMember.text = "\(project!.total_member!)"
    }
}
