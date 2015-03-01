//
//  SubmissionsService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ObjectMapper

class SubmissionsService: EntityWebService, SubmissionsServiceProtocol {
    
    func submissions() -> RACSignal {
        return read("submissions", parameters: nil, page: nil).mapResponses { (submissions: [Submission]) in
            return submissions
        }
    }
    
}