//
//  DiscoverViewController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit
import CoreLocation

private let ShowBraintreeSegueIdentifier = "ShowBraintreeSegueIdentifier"

class DiscoverViewController: UIViewController {
    @IBOutlet internal var snap: UIButton!
    @IBOutlet private var signup: UIBarButtonItem!
    
    private var viewModel: DiscoverViewModel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel = DiscoverViewModel(accessService: ServiceLocator.getService())
        
        signup.rac_command = RACCommand(enabled: viewModel.signupEnabled, signalBlock: { [weak self] _ in
            self?.performSegueWithIdentifier(ShowBraintreeSegueIdentifier, sender: self)
            return RACSignal.empty()
        })

        snap.rac_command = RACCommand(signalBlock: { [weak self] (value) -> RACSignal! in
            RACSignal.createSignal({ [weak self] (subscriber) -> RACDisposable! in
                if let strongSelf = self {
                    let viewModel = ImagePickerViewModel()
                    let imagePickerController: ImagePickerController = ImagePickerController()
                    imagePickerController.viewModel = viewModel
                    
                    viewModel.imageSelected!.subscribeNext({ (image) -> Void in
                        if let image = image as? UIImage {
                            let locationService: LocationServiceProtocol = ServiceLocator.getService()
                            let submissionsService: SubmissionsServiceProtocol = ServiceLocator.getService()
                            let submissionModel = SubmissionViewModel(image: image, locationService: locationService, submissionsService: submissionsService)
                            let submissionViewController = strongSelf.storyboard!.instantiateViewControllerWithIdentifier("submissionViewController") as! SubmissionViewController
                            submissionViewController.viewModel = submissionModel
                            
                            imagePickerController.pushViewController(submissionViewController, animated: true)
                        }
                    }, completed: { [weak self] _ in
                        _ = self?.dismissViewControllerAnimated(true, completion: nil)
                    })

                    strongSelf.navigationController!.presentViewController(imagePickerController, animated: true, completion: { [weak subscriber] _ in
                        _ = subscriber?.sendCompleted()
                    })
                }
                
                return RACDisposable {}
            })
        })
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == ShowBraintreeSegueIdentifier {
//            if let token = viewModel.accessToken {
//                let braintree = Braintree.Client(clientTokenProvider: { (completion) in
//                    return completion(token)
//                })
//                let expiration = Braintree.TokenizationRequest.Expiration(expirationMonth: 12, expirationYear: 2015)
//                
//                // Initialize a Tokenizable, such as CardDetails, based on user input.
//                let card = Braintree.TokenizationRequest.Card(number: "4111111111111111", expiration: expiration)
////                braintree.tokenize(card, completion: handleTokenization)
//            }
//        }
//    }
    
//    lazy var handleTokenization: (Braintree.TokenizationResponse) -> (Void) = { [weak self] result in
//        switch result {
//        case let Braintree.TokenizationResponse.PaymentMethodNonce(nonce):
//            println("Nah \(nonce)")
//        default:
//            break
//        }
//    }
    
}

