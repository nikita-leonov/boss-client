//
//  ImagePickerController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class ImagePickerController: UIImagePickerController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.tintColor = UIColor.blackColor()
        navigationBar.barTintColor = UIColor(red: 248/255, green: 231/255, blue: 28/255, alpha: 1.0)
    }
    
    var viewModel: ImagePickerViewModel! {
        didSet {
            viewModel.imageSelected = rac_imageSelectedSignal()
        }
    }
}