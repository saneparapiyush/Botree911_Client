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

class LoginViewController: AbstractViewController {

    
    @IBOutlet var txtUserEmail: TextFieldValidator!
    @IBOutlet var txtPassword: TextFieldValidator!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        configValidation()
        textFeildReturnUIConfig()
    }// End viewDidLoad()
    
    
    //    MARK: Action
    @IBAction func btnLoginOnclick(_ sender: Any) {
        print("Login Button pressed:")
        userAuthorized()

    }// End btnLoginOnclick()
    
       
    //    MARK: Email Validation
    
    func configValidation()
    {
        txtUserEmail.addRegx(REGEX_EMAIL, withMsg: getLocalizedString("Invalid_Email"))
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
            
            if txtPassword.validate() && txtUserEmail.validate() {
                //              LoginFunctionCall:
                userAuthorized()
            }
            
            break
        default:
            break
        }
        return false
    }// End textFieldShouldReturn()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }// End touchesBegan()
}

extension LoginViewController:AuthorizedProtocol {
    
    func login() -> Bool {
        
        let parameters: Parameters = [
            "user": [
                "email": "spasa@gmail.com",
                "password": "12345678",
                "device_type":1
            ],
            "fcm_token": "dsd"
        ]

        do {
            try Alamofire.request(ComunicateService.Router.SignIn(parameters).asURLRequest()).debugLog().responseJSON(options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableContainers])
            {
                (response) -> Void in
                
                //   print(NSString(data: (response.request?.httpBody!)!, encoding:String.Encoding.utf8.rawValue)!)
                
                switch response.result
                {
                case .success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        print("Login Response: \(json)")
                        
                        if (json.dictionaryObject!["status"] as? Bool)! {
                            print((json.dictionaryObject!["message"])!)
                        } else {
                            print((json.dictionaryObject!["message"])!)
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        } catch  {
            
        }
        
        return false
    }// End login()
    
    //    MARK: Store User Information
    func userAuthorized() {
        if login() {
            print("Move Forword")
        } else {
            print("Don't Move because you are unathorized")
        }
    } //End userAuthorized()
}

protocol AuthorizedProtocol {
    func userAuthorized()
}
