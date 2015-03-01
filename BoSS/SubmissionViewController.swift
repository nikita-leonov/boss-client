//
//  SubmissionViewController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class SubmissionViewController: UITableViewController {
    internal var viewModel: SubmissionViewModel!
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let result = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! SubmissionCell
        result.setViewModel(viewModel)
        return result as! UITableViewCell
    }
}