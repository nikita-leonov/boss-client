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
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        submit.rac_command = RACCommand { [weak self] _ in
            self?.showBraintreeDropInViewController()
            return RACSignal.empty()
        }
        
        viewModel.submit.executionSignals.concat().subscribeNext { [weak self] _ in
            _ = self?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let result = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! SubmissionCell
        result.setViewModel(viewModel)
        return result as! UITableViewCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? CGFloat.min : super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    // MARK: - Interacting with Storyboards
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ShowCategoriesSegueIdentifier {
            let categoriesViewController = segue.destinationViewController as! CategoriesViewController
            
            let categoriesService: CategoriesServiceProtocol = ServiceLocator.getService()
            categoriesViewController.viewModel = CategoriesViewModel(categoriesService: categoriesService)
        }
    }
    
    private func showBraintreeDropInViewController() {
        if let token = viewModel.accessToken {
            let braintree = Braintree(clientToken: token)
            let vc = braintree.dropInViewControllerWithDelegate(self)
            
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindSubmissionTypeViewController(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! CategoriesViewController
        if let categoryViewModel = source.selectedCategory {
            viewModel.category = categoryViewModel.category
            tableView.reloadData()
        }
    }
}

extension SubmissionViewController: BTDropInViewControllerDelegate {
    func dropInViewController(viewController: BTDropInViewController!, didSucceedWithPaymentMethod paymentMethod: BTPaymentMethod!) {
        viewModel.nonce = paymentMethod.nonce
        viewController.dismissViewControllerAnimated(true, completion: { [weak self] _ in
            _ = self?.viewModel.submit.execute(nil)
        })
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController!) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
