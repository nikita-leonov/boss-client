//
//  CategoryTableViewCell.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    internal class func identifier() -> String {
        return "CategoryCellIdentifier"
    }
    
    internal var viewModel: CategoryViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }
    
    private func updateView() {
        if let viewModel = viewModel {
            textLabel?.text = viewModel.categoryName
        } else {
            prepareForReuse()
        }
    }
    
}