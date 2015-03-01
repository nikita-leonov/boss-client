//
//  RACSignal+Mappings.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import ObjectMapper

extension RACSignal {
    
    internal func mapResponses<T: Mappable>(closure: ([T]) -> AnyObject) -> RACSignal {
        return map { (next) -> AnyObject! in
            var result = [T]()
            
            if let responses = next as? [AnyObject] {
                var mapper = Mapper<T>()
                for response in responses {
                    if let mappedObject = mapper.map(response) {
                        result.append(mappedObject)
                    }
                }
            }
            
            return closure(result)
        }
    }
    
    internal func subscribeNextAs<T>(closure: (T -> Void)) -> RACDisposable {
        return subscribeNext { (next: AnyObject!) in
            _ = RACSignal.convertNextAndCallClosure(next, closure: closure)
        }
    }
    
    private class func convertNextAndCallClosure<T,U>(next: AnyObject!, closure: ((T) -> U)) -> U {
        var result: U
        
        if let nextAsT = next as? T {
            result = closure(nextAsT)
        } else {
            assertionFailure("Unexpected type \(T.self) for \(next) in \(__FUNCTION__)")
        }
        
        return result
    }
    
}