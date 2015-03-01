//
//  CategoriesService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

private let categoriesDictionary: [String: String] = [
    "POTHOLE" : "Pothole",
    "DEBRIS" : "Debris on Road",
    "DAMAGED_SIDEWALK" : "Damaged Sidewalk",
    "STREET_SWEEPING" : "Street Cleaning",
    "BROKEN_STREETLIGHTS" : "Broken Streetlight",
]

class CategoriesService: CategoriesServiceProtocol {
    
    internal class func category(forIdentifier identifier: String) -> Category? {
        var result: Category?
        
        if let name = categoriesDictionary[identifier] {
            result = Category(name: name, identifier: identifier)
        }
        
        return result
    }
    
    private lazy var fixedCategories: [Category] = {
        var result = [Category]()
        
        for (id, name) in categoriesDictionary {
            result.append(Category(name: name, identifier: id))
        }
        
        return result
    }()
    
    func categories() -> [Category] {
        return fixedCategories
    }
    
}