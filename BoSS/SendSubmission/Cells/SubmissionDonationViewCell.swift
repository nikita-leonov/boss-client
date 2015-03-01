//
//  SubmissionDonationViewCell.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit

class SubmissionDonationViewCell: UITableViewCell, SubmissionCell {
    
    @IBOutlet internal private(set) weak var stepper: UIStepper!
    @IBOutlet private weak var donate: UILabel!
    
    func setViewModel(viewModel: SubmissionViewModel) {
        stepper.rac_newValueChannelWithNilValue(viewModel.donation).subscribeNextAs { [weak self] (value: Double) in
            viewModel.donation = value
            _ = self?.donate.text = "\(value)"
        }
    }
    
}