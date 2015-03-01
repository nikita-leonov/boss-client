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

class Submission: Mappable {
    
    // MARK: - Properties

    var photo: UIImage?
    var photoURL: NSURL!
    var location: CLLocation?
    var donation: Double!
    var identifier: String!
    
    // MARK: - Initializing a Submission Model
    
    required init() {
    }
    
    func mapping(map: Map) {
        photoURL <- (map["photoURL"], URLTransform())
        location <- (map["location"], LocationTransform())
        donation <- map["donation"]
        identifier <- map["id"]
    }
    
}