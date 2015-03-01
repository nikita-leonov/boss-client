//
//  EntityWebService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation

class EntityWebService {
    
    private let sessionManager: AFHTTPSessionManager
    
    required init(sessionManager: AFHTTPSessionManager) {
        self.sessionManager = sessionManager
    }
    
    internal func read(path: String, parameters: AnyObject? = nil, page: [String: String]? = nil) -> RACSignal {
        return sessionManager.rac_GET(path, parameters: parameters)
    }
    
    internal func upload(image: UIImage) -> RACSignal {
        let baseURL = sessionManager.baseURL
        let fileName = prefix(NSUUID().UUIDString, 16)
        
        return sessionManager.rac_POST("containers/bossimg/upload", constructingBody: { (multipartFormData) in
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            multipartFormData.appendPartWithFileData(imageData, name: "image", fileName: fileName, mimeType: "image/jpg")
        }).map { (x) -> AnyObject! in
            return NSURL(string: "containers/bossimg/download/\(fileName)", relativeToURL: baseURL)
        }
    }
    
    internal func create(path: String, parameters: AnyObject? = nil, page: [String: String]? = nil) -> RACSignal {
        return sessionManager.rac_POST(path, parameters: parameters)
    }
    
}