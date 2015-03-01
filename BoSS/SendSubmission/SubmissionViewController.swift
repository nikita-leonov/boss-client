//
//  SubmissionViewController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit

class SubmissionViewController: UITableViewController {
    
    // MARK: - Properties
    
    internal var viewModel: SubmissionViewModel!
    
    @IBOutlet private weak var submit: UIButton!
    
    private let ShowCategoriesSegueIdentifier = "ShowCategoriesSegueIdentifier"
    
    // MARK: - Managing View Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submit.rac_command = viewModel.submit
        submit.rac_command.executionSignals.concat().subscribeNext { [weak self] _ in
            _ = self?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let result = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! SubmissionCell
        result.setViewModel(viewModel)
        return result as! UITableViewCell
    }
    
    // MARK: - Interacting with Storyboards
    
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