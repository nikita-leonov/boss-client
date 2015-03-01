//
//  CategoriesViewModel.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class CategoriesViewModel {
    
    private let categoriesService: CategoriesServiceProtocol
    
    internal var categories: [String] {
        return categoriesService.categories()
    }
    
    internal var count: Int {
        return categories.count
    }
    
    required init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
    }
    
    internal func categoryViewModel(atIndex index: Int) -> CategoryViewModel {
        return CategoryViewModel(categoryName: categories[index])
    }
    
}