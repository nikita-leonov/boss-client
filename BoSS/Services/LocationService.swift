//
//  LocationService.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import CoreLocation

class LocationService: BaseService {
    private var locationManager: CLLocationManager!
    
    init() {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
    }
}
