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
        showNavigationController()
        getProjectList()
    }
    
    func getProjectList() {
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("project_list_indicator"), userInteractionEnable: false)
        do {
            try Alamofire.request(ComunicateService.Router.ProjectList().asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Project List Response: \(json)")
                        
                        if (json.dictionaryObject!["status"] as? Bool)! {
                            self.processGetResponceProjectList(json: json["data"])
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
    } // End getProjectList()
    
    func processGetResponceProjectList(json: JSON) {
        let projects = json["projects"]
        
        for i in 0 ..< projects.count {
                let jsonValue = projects.arrayValue[i]
                let projectDetail = Project(json: jsonValue)
                projectListSource.append(projectDetail)
        }
        
        tblProjectList.reloadData()
    } // End procssGetResponceProjectList
//    MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTicketList" {
            let ticketListVC = segue.destination as! TicketListViewController
            ticketListVC.projectId = projectListSource[selectProjectIndexPath.row].id!
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
        if indexPath.row == projectListSource.count {
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
    
    func setProjectListData() {
        
        lblProjectTitle.text = project?.name
        lblProjectDescription.text = project?.description
        lblTeamMember.text = "\(project!.total_member!)"
    }
}
