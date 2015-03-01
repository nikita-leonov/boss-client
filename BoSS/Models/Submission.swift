//
//  Submission.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper
import MapKit

class Submission: NSObject, Mappable {
    
    // MARK: - Properties

    var photo: UIImage?
    var photoURL: NSURL!
    var location: CLLocation?
    var donation: Double! = 1.0
    var category: Category! = Category.defaultCategory()
    var status: String! = "CREATED"
    var identifier: String!
    
    // MARK: - Initializing a Submission Model
    
    override required init() {
        super.init()
    }
    
    func mapping(map: Map) {
        photoURL <- (map["photoURL"], URLTransform())
        location <- (map["location"], LocationTransform())
        donation <- map["donation"]
        category <- (map["category"], CategoryTransform())
        status <- map["status"]
        identifier <- map["id"]
    }
    
}

extension Submission: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return location?.coordinate ?? CLLocation(latitude: 0, longitude: 0).coordinate
    }
    
    var title: String {
        return category.name
    }
    
}