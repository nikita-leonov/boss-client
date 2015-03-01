//
//  MapPinViewModel.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import MapKit

class MapPinViewModel: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String! = "TODO"
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}