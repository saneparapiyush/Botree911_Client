//
//  AbstractViewController.swift
//  Botree911
//
//  Created by piyushMac on 01/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit
import FTProgressIndicator
import Toast

protocol Controller {
    var view: View? { get set }
}

protocol View {
    var controller: Controller? { get set }
}

class AbstractViewController: UIViewController, View  {
    
    var controller: Controller?
    var screenType: AppScreenType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func dismissIndicator() {
        DispatchQueue.main.async {
            FTProgressIndicator.dismiss()
        }
    }
    
    func configToast(message: String) {
        
        self.navigationController?.view.makeToast(message)
        
    }//End configToast()
    
    func hideNavigationBar() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    func showNavigationBar() {
        
        if let navController = self.navigationController {
            navController.setNavigationBarHidden(false, animated: true)
        }
    }
}
