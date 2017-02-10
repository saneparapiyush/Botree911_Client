//
//  leftMenuViewController.swift
//  demoSlideMenu
//
//  Created by piyushMac on 17/06/16.
//  Copyright © 2016 piyushMac. All rights reserved.
//

import UIKit
import HMSegmentedControl

class leftMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var tblView: UITableView!
    
    let dsTitle = ["Dashboard","Contacts","Leads","Tasks","Todo","Reports"]
    let dsMenuImage = [UIImage(named: "sm_dashboard_icon"),UIImage(named: "sm_contact_icon"),UIImage(named: "sm_lead_icon"),UIImage(named: "sm_task_icon"),UIImage(named: "sm_todo_icon"),UIImage(named: "sm_report_icon")]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dsTitle.count + 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == dsTitle.count + 1{
            let cell = tblView.dequeueReusableCell(withIdentifier: "SyncCell") as! SyncCell
            
            cell.lblPreviousSync.text = "1 month ago"
            
            return cell
        } else if indexPath.row == 0{
            let cell = tblView.dequeueReusableCell(withIdentifier: "MenuHeaderCell") as! MenuHeaderCell
            
            
            return cell
        } else {
            let cell = tblView.dequeueReusableCell(withIdentifier: "leftMenuCell") as! leftMenuCell
            
            cell.imgMenuIcon.image = dsMenuImage[indexPath.row - 1]
            cell.lblMenuTitle.text = dsTitle[indexPath.row - 1]
            
            return cell
        }
//        cell?.backgroundColor = UIColor.redColor()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == dsTitle.count + 1{
            return 81
        } else if indexPath.row == 0{
            return 100
        } else {
            return 61
        }
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tblView.frame.width, height: 100))
//        view.backgroundColor = themeBlueColor
//        return view
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc : UIViewController?
        if indexPath.row == 0 || indexPath.row == 7 {
            return
        }
        switch indexPath.row {
        case 1:// Dashboard Click in side menu
            vc = AppRouter.sharedRouter().getViewController("dashBoardViewController") as! dashBoardViewController
            

            break
            
        case 2:// Contacts Click in side menu
            vc = AppRouter.sharedRouter().getViewController("dashBoardViewController")
            
            
            break
            
        case 3:// Leads Click in side menu
            
            vc = AppRouter.sharedRouter().getViewController("dashBoardViewController")
            
            break
        case 4:// Tasks Click in side menu
            
            vc = AppRouter.sharedRouter().getViewController("dashBoardViewController")
            break
            
        case 5:// Todo Click in side menu
            
            vc = AppRouter.sharedRouter().getViewController("dashBoardViewController") as! dashBoardViewController
            
            break
        case 6:// Reports Click in side menu
            
            vc = AppRouter.sharedRouter().getViewController("dashBoardViewController") as! dashBoardViewController
            
            break
            
        default:
            break
        }
        navigateView(to: vc!)
//        If Animation True Then Display first all page then pop
    }
    
    func navigateView(to viewController: UIViewController) {
        SlideNavigationController.sharedInstance().popToRootAndSwitch(to: viewController, withSlideOutAnimation: false, andCompletion: nil)
    }
    
}

class leftMenuCell: UITableViewCell {

    @IBOutlet weak var imgMenuIcon: UIImageView!
    
    @IBOutlet weak var lblMenuTitle: UILabel!
}

class SyncCell: UITableViewCell {
    
    @IBOutlet weak var lblPreviousSync: UILabel!
    
    @IBAction func btnSyncPressed(_ sender: AnyObject) {
        
    }
}
class MenuHeaderCell: UITableViewCell {
    @IBOutlet weak var btnUserProfilePic: UIButton!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserEmail: UILabel!
    
    @IBAction func btnSettingOnClick(_ sender: Any) {
        leftMenuViewController().navigateView(to: AppRouter.sharedRouter().getViewController("SettingViewController") as! SettingViewController)
    }
    
}
