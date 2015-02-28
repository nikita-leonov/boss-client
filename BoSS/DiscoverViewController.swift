//
//  DiscoverViewController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit
import CoreLocation

import ReactiveCocoa

class DiscoverViewController: UIViewController {
    @IBOutlet internal var snap: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let imagePickerController:UIImagePickerController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        }
        
        self.navigationController!.presentViewController(imagePickerController, animated: true, completion: nil)

        /*
        snap.rac_command = RACCommand(signalBlock: { [weak self] (value) -> RACSignal! in
            if let strongSelf = self {
                let imagePickerController:UIImagePickerController = UIImagePickerController()
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                    imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                } else {
                    imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                }
                
                strongSelf.navigationController!.presentViewController(imagePickerController, animated: true, completion: nil)
            }
            
            return RACSignal.empty()
        })
        */
    }
}

