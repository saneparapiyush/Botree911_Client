//
//  Utility.swift
//  Botree911
//
//  Created by piyushMac on 01/02/17.
//  Copyright © 2017 piyushMac. All rights reserved.
//

import UIKit


func getLocalizedString(_ localizedKey: String) -> String {
    return NSLocalizedString(localizedKey, comment: "")
}


extension UITextField {
    func addRightSubView() {
        let view = UIView(frame: CGRect(x: self.frame.origin.x - 40, y: 0, width: 30, height: 30))
        let imgView = UIImageView(frame: CGRect(x: 0.0, y: 0, width: 30, height: 30))
        imgView.image = UIImage(named: "drop_down")
        imgView.contentMode = .center
        view.addSubview(imgView)
        self.rightView = view
        rightViewMode = .always
    }
}
