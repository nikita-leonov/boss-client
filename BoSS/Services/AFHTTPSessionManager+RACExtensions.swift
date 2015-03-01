//
//  AFHTTPSessionManager+RACExtensions.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import AFNetworking
import ReactiveCocoa

extension AFHTTPSessionManager {
    
    internal func rac_GET(path: String, parameters: AnyObject? = nil) -> RACSignal {
        return rac_requestPath(path, paramters: parameters, withMethod: "GET")
    }
    
    private func rac_requestPath(path: String, paramters: AnyObject? = nil, withMethod method: String) -> RACSignal {
        return RACSignal.createSignal { [weak self] (subscriber) -> RACDisposable! in
            var result = RACDisposable {}
            
            if let strongSelf = self {
                let URLString = NSURL(string: path, relativeToURL: strongSelf.baseURL)!.absoluteString
                let request = strongSelf.requestSerializer .requestWithMethod(method, URLString: URLString, parameters: paramters, error: nil)
                
                let task = strongSelf.dataTaskWithRequest(request, completionHandler: { (response, responseObject, error) in
                    if (error != nil) {
                        subscriber.sendError(error)
                    } else {
                        subscriber.sendNext(responseObject)
                        subscriber.sendCompleted()
                    }
                })
                
                result = RACDisposable { _ in
                    task.cancel
                }
            }
            
            return result
        }
    }
    
}