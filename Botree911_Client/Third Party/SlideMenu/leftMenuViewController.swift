//
//  leftMenuViewController.swift
//  demoSlideMenu
//
//  Created by piyushMac on 17/06/16.
//  Copyright © 2016 piyushMac. All rights reserved.
//

import UIKit

class leftMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var tblView: UITableView!
    
    let dsTitle = ["All Projects","Logout"]
    let dsMenuImage = [UIImage(named: "project"),UIImage(named: "logout")]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dsTitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblView.dequeueReusableCell(withIdentifier: "leftMenuCell") as! leftMenuCell
            
        cell.imgMenuIcon.image = dsMenuImage[indexPath.row]
        cell.lblMenuTitle.text = dsTitle[indexPath.row]
            
        return cell
//        cell?.backgroundColor = UIColor.redColor()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 61
        } else {
            return 51
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

        switch indexPath.row {
        case 0:// All Project in side menu
            vc = AppRouter.sharedRouter().getViewController("ProjectListViewController") as! ProjectListViewController
            

            break
            
        case 1:// Project Info in side menu
            vc = AppRouter.sharedRouter().getViewController("ProjectListViewController") as! ProjectListViewController
            
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
//
//class SyncCell: UITableViewCell {
//    
//    @IBOutlet weak var lblPreviousSync: UILabel!
//    
//    @IBAction func btnSyncPressed(_ sender: AnyObject) {
//        
//    }
//}
//class MenuHeaderCell: UITableViewCell {
//    @IBOutlet weak var btnUserProfilePic: UIButton!
//    
//    @IBOutlet weak var lblUserName: UILabel!
//    
//    @IBOutlet weak var lblUserEmail: UILabel!
//    
//    @IBAction func btnSettingOnClick(_ sender: Any) {
//        leftMenuViewController().navigateView(to: AppRouter.sharedRouter().getViewController("SettingViewController") as! SettingViewController)
//    }
//    
//}
