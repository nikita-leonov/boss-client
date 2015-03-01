//
//  CategoriesService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class CategoriesService: CategoriesServiceProtocol {
    
    private let fixedCategories: [Category] = [
        Category(name: "Pothole", identifier: "POTHOLE"),
        Category(name: "Debris on Road", identifier: "DEBRIS"),
        Category(name: "Damaged Sidewalk", identifier: "DAMAGED_SIDEWALK"),
        Category(name: "Street Cleaning", identifier: "STREET_SWEEPING"),
        Category(name: "Broken Streetlight", identifier: "BROKEN_STREETLIGHTS")]
    
    func categories() -> [Category] {
        return fixedCategories
    }
    
}