//
//  LoginViewController.swift
//  Botree911
//
//  Created by piyushMac on 01/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FTProgressIndicator
import Toast

class LoginViewController: AbstractViewController {
    
    let testResponse = [
        "first_name": "as",
        "last_name": 1,
        "data": [
            "user": [
                "first_name": "",
                "last_name": "",
                "email": "sp@gmail.com",
                "access_token": "f4cb2196eab3fcae80dc"
            ]
        ]
    ] as [String: Any]
    
    @IBOutlet var txtUserEmail: ThemeTextField!
    @IBOutlet var txtPassword: ThemeTextField!
    @IBOutlet var btnLogin: UIButton!
    
    let btnShowHide = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        if let user = UserDefaults.standard.value(forKey: "user") {
//            print(user)
//            print((user as AnyObject)["email"] as! String)
//        }
        
        title = "SIGN IN"
        //hideNavigationBar()
        self.navigationItem.setHidesBackButton(true, animated: true)
        configValidation()
        configPasswordHideShow()
        textFeildReturnUIConfig()
    }// End viewDidLoad()
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigationBar()
    }
    //    MARK: Action
    @IBAction func btnLoginOnclick(_ sender: Any) {
        userAuthorized()
    }// End btnLoginOnclick()
    @IBAction func btnForgotPasswordOnClick(_ sender: Any) {
        self.view.makeToast("New Password sent to Registered Email")
    }// End btnForgotPasswordOnClick()
    
    
    //    MARK: Email Validation
    
    func configValidation()
    {
//        txtUserEmail.addRegx(REGEX_EMAIL, withMsg: getLocalizedString("invalid_email"))
    }// End isValidEmail
}

//    MARK: KeyBoard Return Key Configuration
extension LoginViewController : UITextFieldDelegate {
    
    func textFeildReturnUIConfig() {
        txtUserEmail.returnKeyType = .next
        txtPassword.returnKeyType = .go
        
        txtUserEmail.enablesReturnKeyAutomatically = true
        txtPassword.enablesReturnKeyAutomatically = true
    }//End textFeildReturnUIConfig()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case txtUserEmail:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            userAuthorized()
            break
        default:
            break
        }
        return false
    }// End textFieldShouldReturn()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }// End touchesBegan()
    
    
    func configPasswordHideShow() {
        btnShowHide.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnShowHide.setImage(UIImage(named: "show"), for: .normal)
        btnShowHide.setTitleColor(UIColor.darkGray, for: .normal)
        btnShowHide.addTarget(self, action: #selector(btnShowHideOnClick), for: .touchUpInside)
        
        txtPassword.rightViewMode = .always
        txtPassword.rightView = btnShowHide
    }
    func btnShowHideOnClick(sender: UIButton) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        txtPassword.isSecureTextEntry ? btnShowHide.setImage(UIImage(named: "show"), for: .normal) : btnShowHide.setImage(UIImage(named: "hide"), for: .normal)
    }
}

extension LoginViewController:AuthorizedProtocol {
    
//    MARK:- Helper Method
    func login(){
        
        let parameters: Parameters = [
            "user": [
                "email": "\(txtUserEmail.text!)",
                "password": "\(txtPassword.text!)",
                "device_type":DEVICE_TOKEN
            ],
            "fcm_token": "dsd"//uuid for iPhone
        ]
        
        FTProgressIndicator.showProgressWithmessage(getLocalizedString("login_indicator"), userInteractionEnable: false)
        
        do {
          try Alamofire.request(ComunicateService.Router.SignIn(parameters).asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                print(NSString(data: (response.request?.httpBody!)!, encoding:String.Encoding.utf8.rawValue)!)
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Login Response: \(json)")
                        
//                        isLoginAuthorized = (json.dictionaryObject!["status"] as? Bool)!
                    
                        if (json.dictionaryObject!["status"] as? Bool)! {

                            if self.storeLoginData(json: json["data"]) {
                                 self.performSegue(withIdentifier: "showProjectList", sender: self)
                            }
                            
                            //                            UserDefaults.standard.set((json.dictionaryObject!["data"] as! [String: Any])["user"]!, forKey: "user")
                            
                        } else {
//                            print((json.dictionaryObject!["message"])!)
                            self.view.makeToast("\((json.dictionaryObject!["message"])!)")
                        }
                    }
                    
                    self.dismissIndicator()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.dismissIndicator()
                    self.view.makeToast(error.localizedDescription)
                }
            }
        } catch let error{
            print(error.localizedDescription)
            self.dismissIndicator()
            self.view.makeToast(error.localizedDescription)
        }
//       return isLoginAuthorized
    }// End login()
    
    func loginDataSource(json: JSON) {
        
            let data = json["user"]
      
            let dic = NSMutableDictionary()
            dic.setValue(data["first_name"].rawString()!, forKey: "first_name")
            dic.setValue(data["last_name"].rawString()!, forKey: "last_name")
            dic.setValue(data["email"].rawString()!, forKey: "email")
            dic.setValue(data["access_token"].rawString()!, forKey: "access_token")
        
            UserDefaults.standard.set(dic, forKey: "user")
    }// loginDataSource()
    
    func storeLoginData(json: JSON) -> Bool {
        let data = json["user"]
        
        let dic = NSMutableDictionary()
        dic.setValue(data["first_name"].rawString()!, forKey: "first_name")
        dic.setValue(data["last_name"].rawString()!, forKey: "last_name")
        dic.setValue(data["email"].rawString()!, forKey: "email")
        dic.setValue(data["access_token"].rawString()!, forKey: "access_token")
        
        UserDefaults.standard.set(dic, forKey: "user")
        UserDefaults.standard.set(txtPassword.text!, forKey: "isLogin")
        UserDefaults.standard.set(true, forKey: "isLogin")
        
        if UserDefaults.standard.value(forKey: "isLogin") != nil {
            return true
        }
        
//        if keychain.set(txtPassword.text!, forKey: "password") {
//            return true
//        }
        
        return false
    }//storeLoginData()
    
    //    MARK: Store User Information
    func userAuthorized() {
//        if txtPassword.validate() && txtUserEmail.validate() {
        
//            MARK: OFLINE
//            login()
            self.performSegue(withIdentifier: "showCreateTicket", sender: self)
//            MARK: END OFLINE
            
//            if login() {
//                print("Move Forword")
//                
//                if keychain.set(txtPassword.text!, forKey: "password") {
//                    performSegue(withIdentifier: "showProjectList", sender: self)
//                }
//            } else {
//                print("Something went wrong in login")
//            }
//        }
    } //End userAuthorized()
}

protocol AuthorizedProtocol {
    func userAuthorized()
}
