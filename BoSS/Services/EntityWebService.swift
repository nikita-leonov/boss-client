//
//  EntityWebService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import AFNetworking
import ReactiveCocoa


class EntityWebService {
    
    private let sessionManager: AFURLSessionManager
    
    required init(sessionManager: AFURLSessionManager) {
        self.sessionManager = sessionManager
    }
    
    internal func read(path: String, parameters: AnyObject? = nil, page: [String: String]? = nil) -> RACSignal? {
        return nil
    }
    
}