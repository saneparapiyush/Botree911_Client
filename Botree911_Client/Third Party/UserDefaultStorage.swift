//
//  UserDefaultStorage.swift
//  G3Telecom
//
//  Created by Valay Patel on 2016-08-20.
//  Copyright © 2016 mTekWorld. All rights reserved.
//

enum StorageType : String {
    case UserDefaults = "UserDefaults"
    static let defaultValue = UserDefaults
}

protocol StorageProtocol {
    func savePair(key: String, data: AnyObject) -> Bool
    func load(key: String) -> AnyObject?
    func remove(key: String) -> Bool
    func clear() -> Bool
}

import Foundation

public class UserDefaultStorage: NSObject,StorageProtocol {
    
    static let sharedStorage = UserDefaultStorage();
    
    private let userDefaults:UserDefaults;
    
    private override init() {
        userDefaults = UserDefaults.standard
    }
    
    public func savePair(key: String, data: AnyObject) -> Bool {
        let archivedData:NSData = NSKeyedArchiver.archivedData(withRootObject: data) as NSData
        userDefaults.set(archivedData, forKey: key)
        return true;
    }
    
    public func load(key: String) -> AnyObject? {
        if let data = UserDefaults.standard.object(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as AnyObject?
        }
        return nil;
    }
    
    public func remove(key: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        return true;
    }

    public func clear() -> Bool {
        UserDefaults.resetStandardUserDefaults()
        return true;
    }
}
