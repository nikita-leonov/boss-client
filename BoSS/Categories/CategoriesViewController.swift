//
//  CategoriesViewController.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    internal var viewModel: CategoriesViewModel!
    
    internal var selectedCategory: CategoryViewModel? {
        var result: CategoryViewModel?
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow() {
            result = viewModel.categoryViewModel(atIndex: selectedIndexPath.row)
        }
        
        return result
    }
    
}

extension CategoriesViewController: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let result = tableView.dequeueReusableCellWithIdentifier(CategoryTableViewCell.identifier(), forIndexPath: indexPath) as! CategoryTableViewCell
        
        result.viewModel = viewModel.categoryViewModel(atIndex: indexPath.row)
        
        return result
    }
    
}