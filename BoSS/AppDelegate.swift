//
//  AppDelegate.swift
//  BoSS
//
//  Created by Nikita Leonov on 2/28/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let baseURL: NSURL = NSURL(string: "http://ec2-52-10-252-124.us-west-2.compute.amazonaws.com/api/")!

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let locationService: LocationServiceProtocol = LocationService()
        ServiceLocator.registerService(locationService)
        
        let sessionManager = AFHTTPSessionManager(baseURL: baseURL)
        sessionManager.requestSerializer = AFJSONRequestSerializer()
        let submissionsService = SubmissionsService(sessionManager: sessionManager)
        ServiceLocator.registerService(submissionsService as SubmissionsServiceProtocol)
        ServiceLocator.registerService(CategoriesService() as CategoriesServiceProtocol)
        ServiceLocator.registerService(AccessService(sessionManager: sessionManager) as AccessServiceProtocol)

        return true
    }
}

