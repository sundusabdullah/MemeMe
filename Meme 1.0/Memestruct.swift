//
//  Memestruct.swift
//  Meme 1.0
//
//  Created by sundus on 02/08/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit


struct Memestruct {
    var topText: String
    var bottomText: String
    var orgImage:  UIImage
    var combiningImage :  UIImage
    
}


class MemeDatabase {
    
    var dataSources:[Memestruct] = []
    static var sheradClass:MemeDatabase? = nil
    
    static func sheard() -> MemeDatabase {
        if let shared = MemeDatabase.sheradClass {
            return shared
        }
        sheradClass = MemeDatabase()
        return sheradClass!
    }
    
}
