//
//  ServiceLocator.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

private class BaseServiceContainer {
    
}

private class ServiceContainer<T> : BaseServiceContainer {
    
    let service: T
    
    init(_ s: T) {
        service = s
    }
}

class ServiceLocator {
    
    private var services = [String: BaseServiceContainer]()
    
    // MARK: - Registering and Accessing Services
    
    internal class func registerService<T>(service: T) {
        let key = "\(T.self)"
        ServiceLocator.sharedInstance.services[key] = ServiceContainer<T>(service)
    }
    
    internal class func getService<T>() -> T {
        let key = "\(T.self)"
        var result = ServiceLocator.sharedInstance.services[key] as? ServiceContainer<T>
        
        if result == nil {
            assertionFailure("WARNING: no service \(key) found")
        }
        return result!.service
    }
    
    // MARK: - Getting the Singleton
    
    private class var sharedInstance: ServiceLocator {
        struct Static {
            static let instance : ServiceLocator = ServiceLocator()
        }
        return Static.instance
    }
}