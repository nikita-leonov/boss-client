//
//  LocationService.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import CoreLocation

class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    private let locationSubject = RACSubject()
    private var locationManager: CLLocationManager!
    private var locationSubscribersCount: Int = 0 {
        didSet {
            if locationSubscribersCount == 0 {
                locationManager.stopUpdatingLocation()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }

    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func currentLocation() -> RACSignal {
        locationSubscribersCount++
        return RACSignal.createSignal { [weak self] (subscriber) -> RACDisposable! in
            var result: RACDisposable = RACDisposable {}
            
            let disposable: RACDisposable? = self?.locationSubject.subscribeNext { (location) -> Void in
                if let location = location as? CLLocation {
                    subscriber.sendNext(location)
                }
            }
            if let disposable = disposable {
                result = disposable
            }
            
            return result
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationSubject.sendNext(locations.last)
    }
}