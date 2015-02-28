//
//  LocationTransform.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper

class LocationTransform: TransformType {
    
    typealias Object = CLLocation
    typealias JSON = String
    
    private let latitudeKey = "lat"
    private let longitudeKey = "lng"
    
    required init() {
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        var result: Object?
        
        if let geopoint = value as? [String: Double] {
            if let latitude = geopoint[latitudeKey], longitude = geopoint[longitudeKey] {
                result = CLLocation(latitude: latitude, longitude: longitude)
            }
        }
        
        return result
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        var result: JSON?
        
        if let coordinate = value?.coordinate {
            result = "{\(latitudeKey): \(coordinate.latitude), \(longitudeKey): \(coordinate.longitude)}"
        }
        
        return result
    }
    
}