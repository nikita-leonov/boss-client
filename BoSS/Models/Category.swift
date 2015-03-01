//
//  Category.swift
//  BoSS
//
//  Created by Emanuele Rudel on 01/03/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class Category {
    
    let name: String
    let identifier: String
    
    internal class func defaultCategory() -> Category {
        return Category(name: "Pothole", identifier: "POTHOLE")
    }
    
    required init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
    }
    
}