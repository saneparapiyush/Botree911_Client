//
//  AddTicketViewController.swift
//  Botree911_Client
//
//  Created by piyushMac on 06/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import FTProgressIndicator
import SwiftyJSON
import Alamofire
import Toast

class AddTicketViewController: AbstractViewController {
    
    @IBOutlet var txtTitleName: TextFieldValidator!
    @IBOutlet var txtViewDescription: UITextView!
    
    @IBOutlet var txtSelectProject: UITextField!
    @IBOutlet var txtSelectStatus: UITextField!
    @IBOutlet var btnCreateTicket: ThemeButton!
    
    var picker = UIPickerView()
    var pickerTag: Int = Int()
    
    var arrStatus = NSMutableDictionary()
    var projectListSource = [Project]()
    var ddProjectId: Int?
    
    var project: Project?
    var ticket: Ticket?
    var isEdit: Bool?
    
    //Edit Ticket
    let fromScreenType: AppScreenType? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (ticket != nil) {
            isEdit = true
        } else {
            isEdit = false
        }
        
        configUI()
        getDropDownData()
    }// End viewDidLoad()
    
    func getDropDownData() {
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("status_list_indicator"), userInteractionEnable: false)

        getStatusList()
        getProjectList()
        self.dismissIndicator()
        picker.dataSource = self
        picker.delegate = self
    }
    
//    MARK:- Helper Method
    func getStatusList() {
        
//        FTProgressIndicator.showProgressWithmessage(getLocalizedString("status_list_indicator"), userInteractionEnable: false)
        do {
            try Alamofire.request(ComunicateService.Router.StatusList().asURLRequest()).responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Stutus List Response: \(json)")
                        
                        if (json.dictionaryObject!["status"] as? Bool)! {
                            self.processGetResponceStutusList(json: json["data"])
                        } else {
                            print((json.dictionaryObject!["message"])!)
                            self.configToast(message: "\((json.dictionaryObject!["message"])!)")
                        }
                    }
                    
//                    self.dismissIndicator()
                case .failure(let error):
                    print(error)
                    self.configToast(message: error.localizedDescription)
//                    self.dismissIndicator()
                }
            }
        } catch let error{
            print(error)
            self.configToast(message: error.localizedDescription)
            //            self.dismissIndicator()
        }
    } // End getProjectList()
    
    func processGetResponceStutusList(json: JSON) {
        let projects: Any = json["ticket_status"]
        
        for (key, value) in projects as! JSON {
            arrStatus[key] = (value.intValue)
        }
        txtSelectStatus.text = (isEdit)! ? (ticket?.status) : (arrStatus.allKeys(for: 1)[0] as! String)
    } // End procssGetResponceProjectList
    
    func getProjectList() {
        
        let serviceManager = ServiceManager()

        serviceManager.getProjectList { (success, error, json) in
            if success {
                self.projectListSource = json!

            } else {
                print(error!)
                self.configToast(message: error!)
            }
        }
    } // End getProjectList()
    
    
    func createTicket() {

        let status: Int = arrStatus["\(txtSelectStatus.text!)"]! as! Int
        
        let parameters = [
            "ticket": [
            "project_id": project!.id!,
            "name": "\(txtTitleName.text!)",
            "status": status,
            "description": "\(txtViewDescription.text!)"
            ]
        ]
        
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("add_project_indicator"), userInteractionEnable: false)
        
        do {
            try Alamofire.request(ComunicateService.Router.CreateTicket(parameters).asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Create Project Response: \(json)")
                        
//                        if (json.dictionaryObject!["status"] as? Bool)! {
//                            
//                            print((json.dictionaryObject!["message"])!)
//                        } else {
//                            print((json.dictionaryObject!["message"])!)
//                        }
                        self.configToast(message: "\((json.dictionaryObject!["message"])!)")
                    }
                    
                    self.dismissIndicator()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.dismissIndicator()
                    self.configToast(message: error.localizedDescription)
                }
            }
        } catch let error{
            print(error.localizedDescription)
            self.dismissIndicator()
            self.configToast(message: error.localizedDescription)
        }
    }//End CreateTicket()
    
    func editTicket() {
        
        let status: Int = arrStatus["\(txtSelectStatus.text!)"]! as! Int
        
        let parameters = [
            "ticket": [
                "project_id": project!.id!,
                "name": "\(txtTitleName.text!)",
                "status": status,
                "description": "\(txtViewDescription.text!)"
            ]
        ]
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("update_project_indicator"), userInteractionEnable: false)
        
        do {
            try Alamofire.request(ComunicateService.Router.EditTicket(parameters, (ticket?.id)!).asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Edit Project Response: \(json)")
                        
//                        if (json.dictionaryObject!["status"] as? Bool)! {
//                            
//                            print((json.dictionaryObject!["message"])!)
//                        } else {
//                            print((json.dictionaryObject!["message"])!)
//                        }
                        self.configToast(message: "\((json.dictionaryObject!["message"])!)")
                    }
                    
                    self.dismissIndicator()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.dismissIndicator()
                    self.configToast(message: error.localizedDescription)
                }
            }
        } catch let error{
            print(error.localizedDescription)
            self.dismissIndicator()
            self.configToast(message: error.localizedDescription)
        }
    }//End editTicket()
    
    func configUI() {
        picker = UIPickerView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 216.0))
        picker.backgroundColor = UIColor.white
        
        txtSelectProject.addRightSubView()
        txtSelectStatus.addRightSubView()
        
        txtSelectProject.inputView = picker
        txtSelectStatus.inputView = picker
        
        txtSelectProject.text = "\(project!.name!)"
        if isEdit! {
            txtTitleName.text = ticket!.name
            txtViewDescription.text = ticket!.description
            txtSelectStatus.text = ticket!.status
            btnCreateTicket.setTitle("Edit Ticket", for: .normal)
        }
    }// End configUI()
    
    func configToast(message: String) {
        self.isEdit! ? self.tabBarController?.view.makeToast(message) : self.view.makeToast(message)
    }//End configToast()


    //MARK:- Actions
    
    @IBAction func btnCreateTicketOnClick(_ sender: Any) {
        if txtTitleName.validate() && txtViewDescription.hasText && txtSelectProject.hasText && txtSelectStatus.hasText {
            
            if (ticket != nil) {
                editTicket()
            } else {
                createTicket()
            }
        } else {
            if !txtViewDescription.hasText {
                print("Enter Description")
            } else if !txtSelectProject.hasText {
                print("Select Project")
            } else if !txtSelectStatus.hasText {
                print("Select Status")
            } // Write toast related message
        }
    }// End btnCreateProjectOnClick()
    
    @IBAction func btnCancelOnClick(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true);
        self.performSegue(withIdentifier: "show", sender: self)
    }// End btnCancelOnClick()    
}

extension AddTicketViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerTag {
        case 101:
            return projectListSource.count
        case 102:
            return arrStatus.count
        default:
            print(pickerTag)
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerTag {
        case 101:
            project = projectListSource[row]
            txtSelectProject.text = projectListSource[row].name
        case 102:
            txtSelectStatus.text = (arrStatus.allKeys[row] as! String)
            
        default:
            print(pickerTag)
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textAlignment = NSTextAlignment.center
        
        switch pickerTag {
        case 101:
            label.text = projectListSource[row].name
        case 102:
            label.text = (arrStatus.allKeys[row] as! String)
        default:
            print(pickerTag)
            break
        }
        return label
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        picker.selectRow(0, inComponent: 0, animated: true)
        
        switch textField {
        case txtSelectProject:
            if projectListSource.count > 0 {
                pickerTag = 101
                
                //     titlePicker.title = " Select XXXX "
            }
        case txtSelectStatus:
            if arrStatus.count > 0 {
                pickerTag = 102

                //   titlePicker.title = " Select XXXX "
            }
        default:
            print(textField)
            break
        }
        
        picker.reloadAllComponents()
    }
}
