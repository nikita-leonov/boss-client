//
//  SubmissionViewModel.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class SubmissionViewModel {
    private var model: Submission
    
    init(image:UIImage) {
        model = Submission()
        model.photo = image
    }
}