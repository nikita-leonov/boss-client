//
//  DiscoverViewController.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DiscoverViewController: UIViewController {
    
    @IBOutlet private var snap: UIButton!
    @IBOutlet private var map: MKMapView!
    
    private var viewModel: DiscoverViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DiscoverViewModel(submissionsService: ServiceLocator.getService())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.readSubmissions().subscribeNextAs { [weak self] (submissions: [Submission]) in
            if let map = self?.map {
                map.removeAnnotations(map.annotations)
                map.addAnnotations(submissions)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        snap.rac_command = RACCommand(signalBlock: { [weak self] (value) -> RACSignal! in
            RACSignal.createSignal({ [weak self] (subscriber) -> RACDisposable! in
                if let strongSelf = self {
                    let viewModel = ImagePickerViewModel()
                    let imagePickerController: ImagePickerController = ImagePickerController()
                    imagePickerController.sourceType = UIImagePickerController.isSourceTypeAvailable(.Camera) ? .Camera : .PhotoLibrary
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
}

extension DiscoverViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var region = MKCoordinateRegionMake(userLocation.location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
}

