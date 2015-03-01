//
//  SubmissionViewModel.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import CoreLocation

class SubmissionViewModel {
    
    // MARK: - Properties
    
    internal var photo: UIImage? {
        return model.photo
    }
    
    internal let locationUpdate: RACSignal!

    internal var location: CLLocation? {
        set {
            model.location = newValue
            locationUpdateSubject.sendNext(model.location!)
        }
        get {
            return model.location
        }
    }
    
    internal var category: Category {
        set {
            model.category = newValue
        }
        get {
            return model.category
        }
    }
    
    internal var donation: Double {
        set {
            model.donation = newValue
        }
        get {
            return model.donation
        }
    }
    
    dynamic internal private(set) var accessToken: String?
    internal var nonce: String?
    
    internal lazy var submit: RACCommand = RACCommand { [weak self] _ in
        var result = RACSignal.empty()
        
        if let submissionsService = self?.submissionsService, photo = self?.photo, model = self?.model, nonce = self?.nonce {
            result = submissionsService.upload(photo).doNext { (x) in
                if let URL = x as? NSURL {
                    model.photoURL = URL
                }
            }.flattenMap { _ in
                return submissionsService.create(model, nonce: nonce)
            }
        }
        
        return result
    }
    
    private var model: Submission
    private let locationUpdateSubject: RACSubject = RACSubject()
    private let submissionsService: SubmissionsServiceProtocol
    
    // MARK: - Initializing the Submission View Model
    
    init(image:UIImage, locationService: LocationServiceProtocol, submissionsService: SubmissionsServiceProtocol) {
        locationUpdate = locationUpdateSubject
        self.submissionsService = submissionsService
        
        model = Submission()
        model.photo = image
        
        locationService.currentLocation().subscribeNext { [weak self] (location) -> Void in
            if let location = location as? CLLocation {
                self?.location = location
            }
        }
        
        submissionsService.getToken().subscribeNextAs { [weak self] (response: [String: String]) in
            _ = self?.accessToken = response["token"]!
        }
    }
    
}