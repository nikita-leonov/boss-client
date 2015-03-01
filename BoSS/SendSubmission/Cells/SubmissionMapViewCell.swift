//
//  SubmissionMapViewCell.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class SubmissionMapViewCell: UITableViewCell, SubmissionCell {
    var annotation: MapPinViewModel!
    @IBOutlet var map: MKMapView!
    
    func setViewModel(viewModel: SubmissionViewModel) {
        if let location = viewModel.location {
            map.setCenterCoordinate(location.coordinate, animated: true)
        } else {
            viewModel.locationUpdate.subscribeNext { [weak self] (location) -> Void in
                if let location = location as? CLLocation {
                    if (self?.annotation == nil) {
                        self?.annotation = MapPinViewModel(coordinate: location.coordinate)
                        self?.map.addAnnotation(self?.annotation)
                        self?.map.setCenterCoordinate(location.coordinate, animated: true)
                    }
                }
            }
        }
    }
}