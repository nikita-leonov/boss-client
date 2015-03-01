//
//  ImagePickerController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ImagePickerController: UIImagePickerController {
    var viewModel: ImagePickerViewModel! {
        didSet {
            viewModel.imageSelected = rac_imageSelectedSignal()
        }
    }
}