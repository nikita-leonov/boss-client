//
//  ImagePickerViewModel.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class ImagePickerViewModel {
    private var _imageSelected: RACSignal?
    internal var imageSelected: RACSignal? {
        set {
            _imageSelected = newValue?.map({ (imageInfo) -> AnyObject! in
                var result: UIImage!
                
                if let imageInfo = imageInfo as? [String: AnyObject] {
                    result = imageInfo[UIImagePickerControllerOriginalImage] as? UIImage
                }
                
                return result
            })

            //TODO: Upload etc
        }
        get {
            return _imageSelected
        }
    }
}