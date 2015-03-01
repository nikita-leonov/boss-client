//
//  SubmissionsService.swift
//  BoSS
//
//  Created by Emanuele Rudel on 28/02/15.
//  Copyright (c) 2015 Bureau of Street Services. All rights reserved.
//

import Foundation
import ObjectMapper

class SubmissionsService: EntityWebService, SubmissionsServiceProtocol {
    
    func submissions() -> RACSignal {
        return read("submissions").mapResponses { (submissions: [Submission]) in
            return submissions
        }
    }
    
    func getToken() -> RACSignal {
        return read("ClientTokens/generate")
    }
    
    func create(submission: Submission, nonce: String) -> RACSignal {
        let mapper = Mapper<Submission>()
        let request = mapper.toJSON(submission)
        return create("submissions", parameters: request).flattenMap { [weak self] (x) in
            var result = RACSignal.empty()
            
            if let strongSelf = self, newSubmission = mapper.map(x) {
                let parameters = ["amount": submission.donation, "paymentMethodNonce": nonce]
                return strongSelf.create("submissions/\(newSubmission.identifier)/payments", parameters: parameters)
            }
            
            return result
        }
    }
    
}