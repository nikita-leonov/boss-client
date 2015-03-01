//
//  SubmissionViewModel.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import CoreLocation
import ReactiveCocoa

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
    
    internal var category: String {
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
    
    internal lazy var submit: RACCommand = RACCommand(enabled: self.enabled()) { [weak self] _ in
        var result = RACSignal.empty()
        
        if let strongSelf = self {
            result = strongSelf.submissionsService.create(strongSelf.model)
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
        
        locationService.currentLocation().take(1).subscribeNext { [weak self] (location) -> Void in
            if let location = location as? CLLocation {
                self?.location = location
            }
        }
    }
    
    private func enabled() -> RACSignal {
        return RACSignal.`return`(true)
    }
    
}