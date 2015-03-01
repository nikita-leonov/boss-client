//
//  CategoryTransform.swift
//  BoSS
//
//  Created by Emanuele Rudel on 01/03/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryTransform: TransformType {
    
    typealias Object = Category
    typealias JSON = String
    
    required init() {
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        var result: Object?
        
        if let id = value as? String {
            result = CategoriesService.category(forIdentifier: id)
        }
        
        return result
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        return value?.identifier
    }
    
}