//
//  CategoriesService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class CategoriesService: CategoriesServiceProtocol {
    
    private let fixedCategories: [String] = ["POTHOLE", "DEBRIS", "DAMAGED_SIDEWALK", "STREET_SWEEPING", "BROKEN_STREETLIGHTS"]
    
    func categories() -> [String] {
        return fixedCategories
    }
    
}