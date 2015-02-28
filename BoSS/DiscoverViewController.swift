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

        snap.rac_command = RACCommand(signalBlock: { [weak self] (value) -> RACSignal! in
            RACSignal.createSignal({ [weak self] (subscriber) -> RACDisposable! in
                if let strongSelf = self {
                    let imagePickerController: ImagePickerController = ImagePickerController()
                    
                    strongSelf.navigationController!.presentViewController(imagePickerController, animated: true, completion: { [weak subscriber] _ in
                        _ = subscriber?.sendCompleted()
                    })
                }
                
                return RACDisposable {}
            })
        })
    }
}

