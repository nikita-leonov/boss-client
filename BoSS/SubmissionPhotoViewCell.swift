//
//  SubmissionPhotoViewCell.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class SubmissionPhotoViewCell: UITableViewCell, SubmissionCell {
    @IBOutlet var photo: UIImageView!
    
    func setViewModel(viewModel: SubmissionViewModel) {
        photo.image = viewModel.photo
    }
}