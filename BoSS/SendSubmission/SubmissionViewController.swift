//
//  SubmissionViewController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit

class SubmissionViewController: UITableViewController {
    
    internal var viewModel: SubmissionViewModel!
    
    private let ShowCategoriesSegueIdentifier = "ShowCategoriesSegueIdentifier"
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let result = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! SubmissionCell
        result.setViewModel(viewModel)
        return result as! UITableViewCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ShowCategoriesSegueIdentifier {
            let categoriesViewController = segue.destinationViewController as! CategoriesViewController
            
            let categoriesService: CategoriesServiceProtocol = ServiceLocator.getService()
            categoriesViewController.viewModel = CategoriesViewModel(categoriesService: categoriesService)
        }
    }
    
    @IBAction func unwindSubmissionTypeViewController(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! CategoriesViewController
        if let categoryViewModel = source.selectedCategory {
            viewModel.category = categoryViewModel.categoryName
            tableView.reloadData()
        }
    }
}