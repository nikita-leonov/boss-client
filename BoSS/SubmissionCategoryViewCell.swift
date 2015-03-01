//
//  SubmissionCategoryViewCell.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit

class SubmissionCategoryViewCell: UITableViewCell, SubmissionCell {
    
    func setViewModel(viewModel: SubmissionViewModel) {
        detailTextLabel?.text = viewModel.category
    }
    
}